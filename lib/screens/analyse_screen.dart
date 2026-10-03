import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../l10n.dart';
import '../services/api_service.dart';
import '../services/database_service.dart';
import '../theme.dart';
import '../widgets/ethic_banner.dart';

class AnalyseScreen extends StatefulWidget {
  const AnalyseScreen({super.key});

  @override
  State<AnalyseScreen> createState() => _AnalyseScreenState();
}

class _AnalyseScreenState extends State<AnalyseScreen> {
  // endpoint backend -> clé de traduction
  static const modules = {
    'colorimetrie': 'm_colorimetrie',
    'sediment_urinaire': 'm_sediment_urinaire',
    'groupe_sanguin': 'm_groupe_sanguin',
    'paludisme': 'm_paludisme',
    'oeil': 'm_oeil',
  };

  String _module = 'colorimetrie';
  XFile? _image;
  bool _consent = false;
  bool _busy = false;
  Map<String, dynamic>? _result;
  String? _error;

  Future<void> _pick(ImageSource source) async {
    final f = await ImagePicker().pickImage(source: source, imageQuality: 90);
    if (f != null) {
      setState(() {
        _image = f;
        _result = null;
        _error = null;
      });
    }
  }

  void _msg(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  Future<void> _analyze() async {
    if (_image == null) return _msg(tr(context, 'need_image'));
    if (!_consent) return _msg(tr(context, 'need_consent'));
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final r = await ApiService.analyze(_module, _image!.path);
      setState(() => _result = r);
    } catch (_) {
      setState(() => _error = tr(context, 'error_server'));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _save() async {
    final r = _result;
    if (r == null) return;
    await DatabaseService.insert({
      'module': _module,
      'result': '${r['resultat']}',
      'confidence': (r['score_confiance'] as num?)?.toDouble() ?? 0.0,
      'image_path': _image?.path,
      'created_at': DateTime.now().toIso8601String(),
    });
    if (mounted) _msg(tr(context, 'saved'));
  }

  @override
  Widget build(BuildContext context) {
    final conf = (_result?['score_confiance'] as num?)?.toDouble();
    final lowConf = conf != null && conf < 0.6;

    return Scaffold(
      appBar: AppBar(title: Text(tr(context, 'home_analysis'))),
      bottomNavigationBar: const EthicBanner(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          DropdownButtonFormField<String>(
            value: _module,
            decoration: InputDecoration(labelText: tr(context, 'module'), border: const OutlineInputBorder()),
            items: modules.entries
                .map((e) => DropdownMenuItem(value: e.key, child: Text(tr(context, e.value))))
                .toList(),
            onChanged: (v) => setState(() {
              _module = v!;
              _result = null;
            }),
          ),
          if (_module == 'groupe_sanguin')
            Container(
              margin: const EdgeInsets.only(top: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF3CD),
                border: Border.all(color: gold),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(tr(context, 'blood_warn'), style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
          const SizedBox(height: 16),
          if (_image != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(File(_image!.path), height: 220, fit: BoxFit.cover),
            ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _pick(ImageSource.camera),
                  icon: const Icon(Icons.camera_alt),
                  label: Text(tr(context, 'camera')),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _pick(ImageSource.gallery),
                  icon: const Icon(Icons.photo_library),
                  label: Text(tr(context, 'gallery')),
                ),
              ),
            ],
          ),
          CheckboxListTile(
            value: _consent,
            onChanged: (v) => setState(() => _consent = v ?? false),
            title: Text(tr(context, 'consent')),
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
          ),
          ElevatedButton(
            onPressed: _busy ? null : _analyze,
            child: _busy
                ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                : Text(tr(context, 'analyze')),
          ),
          if (_error != null)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(_error!, style: const TextStyle(color: Colors.red)),
            ),
          if (_result != null) ...[
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(tr(context, 'result'), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: emerald)),
                    const SizedBox(height: 8),
                    Text(lowConf ? tr(context, 'low_conf') : '${_result!['resultat']}', style: const TextStyle(fontSize: 20)),
                    if (conf != null) Text('${tr(context, 'confidence')} : ${(conf * 100).toStringAsFixed(0)} %'),
                    const SizedBox(height: 8),
                    Text(tr(context, 'warning'), style: const TextStyle(fontStyle: FontStyle.italic, color: gold)),
                    if (!lowConf)
                      Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: TextButton.icon(
                          onPressed: _save,
                          icon: const Icon(Icons.save),
                          label: Text(tr(context, 'save')),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

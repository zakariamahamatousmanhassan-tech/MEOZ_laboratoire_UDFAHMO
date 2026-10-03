import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n.dart';
import '../theme.dart';
import '../widgets/ethic_banner.dart';
import '../widgets/islamic_pattern.dart';
import 'analyse_screen.dart';
import 'dossier_patient_screen.dart';
import 'medecine_islamique_screen.dart';
import 'technologie_screen.dart';

class _Item {
  final IconData icon;
  final String key;
  final Widget page;
  const _Item(this.icon, this.key, this.page);
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = <_Item>[
      const _Item(Icons.biotech, 'home_analysis', AnalyseScreen()),
      const _Item(Icons.folder_shared, 'home_records', DossierPatientScreen()),
      const _Item(Icons.menu_book, 'home_islamic', MedecineIslamiqueScreen()),
      const _Item(Icons.memory, 'home_tech', TechnologieScreen()),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('M.E.O.Z'),
        actions: [
          TextButton(
            onPressed: () => context.read<LocaleController>().toggle(),
            child: Text(
              tr(context, 'lang'),
              style: const TextStyle(color: gold, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          const Positioned.fill(
            child: CustomPaint(painter: IslamicPatternPainter(Color(0x26C9A227))),
          ),
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'بسم الله الرحمن الرحيم',
                  style: TextStyle(fontSize: 22, color: emerald, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  padding: const EdgeInsets.all(16),
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  children: items.map((i) => _card(context, i)).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: const EthicBanner(),
    );
  }

  Widget _card(BuildContext context, _Item i) {
    return Card(
      color: Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => i.page)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(i.icon, size: 48, color: emerald),
            const SizedBox(height: 12),
            Text(
              tr(context, i.key),
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

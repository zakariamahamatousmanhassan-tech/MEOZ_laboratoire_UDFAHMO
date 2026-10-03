import 'package:flutter/material.dart';

import '../l10n.dart';
import '../theme.dart';
import '../widgets/ethic_banner.dart';

class MedecineIslamiqueScreen extends StatelessWidget {
  const MedecineIslamiqueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr(context, 'home_islamic'))),
      bottomNavigationBar: const EthicBanner(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _section(context, Icons.bug_report, 'microbiology'),
          _section(context, Icons.spa, 'traditional'),
          const SizedBox(height: 16),
          _note(context, 'verses'),
          _note(context, 'supplements'),
          _note(context, 'doctor_only'),
        ],
      ),
    );
  }

  Widget _section(BuildContext context, IconData icon, String key) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: emerald),
        title: Text(tr(context, key), style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(tr(context, 'to_complete')),
      ),
    );
  }

  Widget _note(BuildContext context, String key) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline, size: 18, color: gold),
          const SizedBox(width: 8),
          Expanded(child: Text(tr(context, key))),
        ],
      ),
    );
  }
}

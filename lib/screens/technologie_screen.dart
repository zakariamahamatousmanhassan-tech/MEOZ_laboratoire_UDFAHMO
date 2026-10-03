import 'package:flutter/material.dart';

import '../l10n.dart';
import '../theme.dart';
import '../widgets/ethic_banner.dart';

class TechnologieScreen extends StatelessWidget {
  const TechnologieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = <MapEntry<IconData, String>>[
      const MapEntry(Icons.electrical_services, 'tech_electronics'),
      const MapEntry(Icons.psychology, 'tech_ai'),
      const MapEntry(Icons.local_hospital, 'tech_system'),
      const MapEntry(Icons.bluetooth_searching, 'tech_connect'),
    ];
    return Scaffold(
      appBar: AppBar(title: Text(tr(context, 'home_tech'))),
      bottomNavigationBar: const EthicBanner(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          for (final e in items)
            Card(
              child: ListTile(
                leading: Icon(e.key, color: emerald),
                title: Text(tr(context, e.value), style: const TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Text(tr(context, 'to_complete')),
              ),
            ),
        ],
      ),
    );
  }
}

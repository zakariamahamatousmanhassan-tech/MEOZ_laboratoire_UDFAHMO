import 'package:flutter/material.dart';

import '../l10n.dart';
import '../services/database_service.dart';
import '../theme.dart';
import '../widgets/ethic_banner.dart';

class DossierPatientScreen extends StatelessWidget {
  const DossierPatientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr(context, 'home_records'))),
      bottomNavigationBar: const EthicBanner(),
      body: FutureBuilder<List<Map<String, Object?>>>(
        future: DatabaseService.all(),
        builder: (context, snap) {
          if (!snap.hasData) return const Center(child: CircularProgressIndicator());
          final rows = snap.data!;
          if (rows.isEmpty) return Center(child: Text(tr(context, 'no_records')));
          return ListView.separated(
            itemCount: rows.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (_, i) {
              final r = rows[i];
              final conf = ((r['confidence'] as num?) ?? 0) * 100;
              return ListTile(
                leading: const Icon(Icons.science, color: emerald),
                title: Text('${r['module']} : ${r['result']}'),
                subtitle: Text('${r['created_at']}  •  ${conf.toStringAsFixed(0)} %'),
              );
            },
          );
        },
      ),
    );
  }
}

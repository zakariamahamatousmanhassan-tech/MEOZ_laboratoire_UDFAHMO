import 'package:flutter/material.dart';
import '../l10n.dart';
import '../theme.dart';

class EthicBanner extends StatelessWidget {
  const EthicBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: emerald,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Text(
            '${tr(context, 'warning')}\n${tr(context, 'doctor_only')}',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 12, height: 1.4),
          ),
        ),
      ),
    );
  }
}

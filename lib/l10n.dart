import 'package:flutter/material.dart';

class LocaleController extends ChangeNotifier {
  Locale locale = const Locale('fr');

  void toggle() {
    locale = locale.languageCode == 'fr' ? const Locale('ar') : const Locale('fr');
    notifyListeners();
  }
}

const Map<String, Map<String, String>> _s = {
  'fr': {
    'lang': 'العربية',
    'warning': 'Estimation assistée par IA. À confirmer par un laboratoire.',
    'doctor_only': 'Le médecin seul pose le diagnostic.',
    'home_analysis': 'Analyse',
    'home_records': 'Dossiers patients',
    'home_islamic': 'Médecine Islamique',
    'home_tech': 'Technologie',
    'module': 'Module d\'analyse',
    'm_colorimetrie': 'Colorimétrie (bandelettes)',
    'm_sediment_urinaire': 'Sédiment urinaire',
    'm_groupe_sanguin': 'Groupe sanguin',
    'm_paludisme': 'Paludisme (TDR)',
    'm_oeil': 'Œil',
    'blood_warn': 'Ne jamais utiliser ce résultat pour une transfusion. Confirmation en laboratoire obligatoire.',
    'consent': 'Le patient a donné son consentement éclairé',
    'camera': 'Prendre une photo',
    'gallery': 'Galerie',
    'analyze': 'Analyser',
    'result': 'Résultat',
    'confidence': 'Confiance',
    'low_conf': 'Résultat non concluant — refaire la capture',
    'save': 'Enregistrer dans le dossier',
    'saved': 'Enregistré dans le dossier patient',
    'no_records': 'Aucun dossier',
    'error_server': 'Serveur injoignable. Vérifiez l\'adresse du backend.',
    'need_image': 'Ajoutez d\'abord une image.',
    'need_consent': 'Le consentement éclairé est obligatoire.',
    'microbiology': 'Microbiologie',
    'traditional': 'Médecine traditionnelle',
    'tech_electronics': 'Électronique et électrique',
    'tech_ai': 'IA et codage',
    'tech_system': 'Système informatique médical',
    'tech_connect': 'Connexion microscope (Wi-Fi / Bluetooth)',
    'to_complete': 'Contenu à valider et à compléter',
    'verses': 'Les versets doivent être validés par un savant qualifié.',
    'supplements': 'Le miel et la nigelle ne remplacent jamais un traitement.',
  },
  'ar': {
    'lang': 'Français',
    'warning': 'تقدير بمساعدة الذكاء الاصطناعي. يجب تأكيده في المختبر.',
    'doctor_only': 'الطبيب وحده يضع التشخيص.',
    'home_analysis': 'تحليل',
    'home_records': 'ملفات المرضى',
    'home_islamic': 'الطب الإسلامي',
    'home_tech': 'التكنولوجيا',
    'module': 'وحدة التحليل',
    'm_colorimetrie': 'قياس الألوان (الشرائط)',
    'm_sediment_urinaire': 'الرسابة البولية',
    'm_groupe_sanguin': 'فصيلة الدم',
    'm_paludisme': 'الملاريا (اختبار سريع)',
    'm_oeil': 'العين',
    'blood_warn': 'لا تستخدم هذه النتيجة أبدًا لنقل الدم. التأكيد في المختبر إلزامي.',
    'consent': 'قدّم المريض موافقته المستنيرة',
    'camera': 'التقاط صورة',
    'gallery': 'المعرض',
    'analyze': 'تحليل',
    'result': 'النتيجة',
    'confidence': 'الثقة',
    'low_conf': 'نتيجة غير حاسمة — أعد التقاط الصورة',
    'save': 'حفظ في الملف',
    'saved': 'تم الحفظ في ملف المريض',
    'no_records': 'لا توجد ملفات',
    'error_server': 'تعذر الاتصال بالخادم. تحقق من عنوان الخادم.',
    'need_image': 'أضف صورة أولاً.',
    'need_consent': 'الموافقة المستنيرة إلزامية.',
    'microbiology': 'علم الأحياء الدقيقة',
    'traditional': 'الطب التقليدي',
    'tech_electronics': 'الإلكترونيات والكهرباء',
    'tech_ai': 'الذكاء الاصطناعي والبرمجة',
    'tech_system': 'النظام المعلوماتي الطبي',
    'tech_connect': 'ربط المجهر (واي فاي / بلوتوث)',
    'to_complete': 'محتوى قيد المراجعة والإكمال',
    'verses': 'يجب أن يراجع عالم مؤهل الآيات.',
    'supplements': 'العسل والحبة السوداء لا يغنيان عن العلاج.',
  },
};

String tr(BuildContext context, String key) {
  final lang = Localizations.localeOf(context).languageCode;
  return _s[lang]?[key] ?? _s['fr']![key] ?? key;
}

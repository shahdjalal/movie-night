// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'متجري';

  @override
  String get name => 'الاسم';

  @override
  String get nameDesc => 'أدخل اسمك';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get emailDesc => 'أدخل بريدك الالكتروني';

  @override
  String get phone => 'الهاتف';

  @override
  String get phoneDecs => 'أدخل رقم هاتفك';

  @override
  String get password => 'كلمة المرور';

  @override
  String get passwordDesc => ' أدخل كلمة السر';

  @override
  String get passwordConfirm => 'تأكيد كلمة المرور';

  @override
  String get passwordConfirmDesc => 'أدخل كلمة المرور مرةأخرى';

  @override
  String get required => 'هذا الحقل مطلوب';

  @override
  String get length => 'يجب أن يكون الاسم على الاقل ثلاث حروف';

  @override
  String get validEmail => 'الرجاء ادخال بريد الكتروني صالح';

  @override
  String get match => 'كلمات المرور غير متطابقة';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String welcome(Object name) {
    return '$nameمرحبا';
  }
}

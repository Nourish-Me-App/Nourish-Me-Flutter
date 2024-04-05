class AuthErrorMessages {
  AuthErrorMessages._();
  static String authErrorMessage(String? error) {
    if (error == 'Invalid credentials') {
      return 'يوجد خطأ في إسم المستخدم أو كلمة المرور';
    }
    if (error == 'The email field must be a valid email address.') {
      return 'البريد الألكتروني غير صالح';
    }
    if (error == 'The email has already been taken.') {
      return 'البريد الألكتروني مستخدم بالفعل';
    }
    if (error == 'لا يوجد إتصال بالإنترنت أو يوجد خطأ في السيرفر') {
      return 'لا يوجد إتصال بالإنترنت أو يوجد خطأ في السيرفر';
    }
    if (error == 'حاول مرة أخري في وقت لاحق') {
      return 'حاول مرة أخري في وقت لاحق';
    } 
    if(error == 'The code has already been sent before 1 minute'){
      return 'تم إرسال الكود بالفعل منذ دقيقة';

    }
    if (error == null || error.isEmpty) {
      return 'عذرا يوجد خطأ ، حاول مرة أخري في وقت لاحق';
    } else {
      return 'عذرا يوجد خطأ ، حاول مرة أخري في وقت لاحق';
    }
    
  }
}

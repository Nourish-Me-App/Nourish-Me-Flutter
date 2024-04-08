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
    // if (error == 'حاول مرة أخري في وقت لاحق') {
    //   return 'حاول مرة أخري في وقت لاحق';
    // }
    if(error == 'A reset code has already been sent to this email. Please check your email'){
      return 'تم إرسال الكود بالفعل الس الايميل الخاص بك';

    }
    if(error == 'The selected email is invalid.'){
      return 'البريد الإلكتروني غير صالح';
    }
    if(error == 'Invalid or expired token'){
      return 'الكود غير صالح';
    }
    if(error=='The token field must be 6 digits.'){
      return 'الكود يجب ان يكون 6 ارقام';
    }
    if(error=='Invalid or expired token'){
      return 'الكود غير صالح او انتهة المده الزمنيه الخاصه به';
    }
    if (error == null || error.isEmpty) {
      return 'عذرا يوجد خطأ ، حاول مرة أخري في وقت لاحق';
    } else {
      return 'عذرا يوجد خطأ ، حاول مرة أخري في وقت لاحق';
    }
    
  }
}

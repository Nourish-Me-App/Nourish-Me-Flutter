class ErrorMessages {
  ErrorMessages._();
  static String errorMessage(String? error) {
    if (error == 'Invalid credentials') {
      return 'يوجد خطأ في إسم المستخدم أو كلمة المرور';
    }
    if (error == 'The email field must be a valid email address.') {
      return 'البريد الألكتروني غير صالح';
    }
    if (error == 'The email has already been taken.' ||
        error == 'The email has already been taken. (and 2 more errors)') {
      return 'البريد الألكتروني مستخدم بالفعل';
    }
    if (error == 'لا يوجد إتصال بالإنترنت أو يوجد خطأ في السيرفر') {
      return 'لا يوجد إتصال بالإنترنت أو يوجد خطأ في السيرفر';
    }
    if (error == 'حاول مرة أخري في وقت لاحق') {
      return 'حاول مرة أخري في وقت لاحق';
    }
    if (error ==
        'A reset code has already been sent to this email. Please check your email') {
      return 'تم إرسال الكود بالفعل إلي البريد الالكتروني الخاص بك';
    }
    if (error == 'The selected email is invalid.') {
      return 'البريد الإلكتروني غير صالح';
    }
    if (error == 'Invalid or expired token') {
      return 'الكود غير صالح';
    }
    if (error == 'The token field must be 6 digits.') {
      return 'الكود يجب أن يكون 6 أرقام';
    }
    if (error == 'Invalid or expired token') {
      return 'الكود غير صالح أو إنتهت المدة الزمنية الخاصة به';
    }
    if (error == 'Incorrect old password') {
      return 'كلمة المرور الحالية غير صحيحة';
    }
    if (error == 'There Is No Diet Fit With This Information') {
      return 'لا يوجد نظام غذائي يتناسب مع هذه المعلومات';
    }
    if (error == null || error.isEmpty) {
      return 'عذرا يوجد خطأ ، حاول مرة أخري في وقت لاحق';
    } else {
      return 'عذرا يوجد خطأ ، حاول مرة أخري في وقت لاحق';
    }
  }
}

class ValidationErrorTexts {
  ValidationErrorTexts._();

  static String? firstNameValidation(String? firstName) {
    if (firstName == null || firstName.isEmpty) {
      return 'برجاء إدخال الإسم الأول';
    }
    return null;
  }

  static String? lastNameValidation(String? lastName) {
    if (lastName == null || lastName.isEmpty) {
      return 'برجاء إدخال الإسم الأخير';
    }
    return null;
  }

  static String? signUpPasswordValidation(String? password) {
    if (password == null || password.isEmpty) {
      return 'برجاء إدخال كلمة المرور';
    }
    if (password.length < 8) {
      return 'كلمة المرور يجب ألا تقل عن 8 حروف';
    }
    if (!password.contains(RegExp(r'[!@#$%^&*\-+=_(),.?":{}|<>]'))) {
      return 'كلمة المرور يجب أن تحتوي على حرف خاص علي الأقل';
    }
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return 'كلمة المرور يجب أن تحتوي على حرف كبير علي الأقل';
    }
    if (!password.contains(RegExp(r'[0-9]'))) {
      return 'كلمة المرور يجب أن تحتوي على رقم علي الأقل';
    }
    return null;
  }

  static String? loginPasswordValidation(String? password) {
    if (password == null || password.isEmpty) {
      return 'برجاء إدخال كلمة المرور';
    }
    if (password.length < 8) {
      return 'كلمة المرور يجب ألا تقل عن 8 حروف';
    }
    return null;
  }

  static String? confirmPasswordValidation(
    String? passwordConfirmation,
    String? password,
  ) {
    if (passwordConfirmation == null || passwordConfirmation.isEmpty) {
      return 'برجاء تأكيد كلمة المرور';
    }
    if (password != passwordConfirmation) {
      return 'كلمة المرور غير متطابقة';
    }
    return null;
  }

  static String? emailValidation(String? email) {
    if (email == null || email.isEmpty) {
      return 'برجاء إدخال البريد الإلكتروني';
    }
    if (email.length < 5) {
      return 'برجاء إدخال البريد الإلكتروني بشكل صحيح';
    }
    if (!email.contains('@')) {
      return 'برجاء إدخال البريد الإلكتروني بحيث يحتوي على @';
    }
    return null;
  }
}

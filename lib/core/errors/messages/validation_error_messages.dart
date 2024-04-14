class ValidationErrorTexts {
  ValidationErrorTexts._();

  static String? firstNameValidation(String? firstName) {
    if (firstName == null || firstName.isEmpty || firstName.trim().isEmpty) {
      return 'برجاء إدخال الإسم الأول';
    }
    if (firstName.contains(RegExp(r'[^\w\s]+')) || firstName.contains('_')) {
      return 'لا تستخدم حروف خاصة';
    }
    if (firstName.contains(' ')) {
      return 'لا تستخدم مسافات';
    }
    if (!firstName.contains(RegExp(r'\D+'))) {
      return 'لا تستخدم أرقام';
    }
    if (firstName.length < 2) {
      return 'الإسم الأول يجب ألا يقل عن حرفين';
    }
    return null;
  }

  static String? otpValidation(
    String? field,
  ) {
    if (field == null || field.isEmpty) {
      return '                                                  برجاء إدخال الرمز';
    }
    if (field.length < 6) {
      return '                                           الرمز يجب أن يكون 6 أرقام';
    }
    return null;
  }

  static String? lastNameValidation(String? lastName) {
    if (lastName == null || lastName.isEmpty || lastName.trim().isEmpty) {
      return 'برجاء إدخال الإسم الأخير';
    }
    if (lastName.contains(RegExp(r'[^\w\s]+')) || lastName.contains('_')) {
      return 'لا تستخدم حروف خاصة';
    }
    if (lastName.contains(' ')) {
      return 'لا تستخدم مسافات';
    }
    if (!lastName.contains(RegExp(r'\D+'))) {
      return 'لا تستخدم أرقام';
    }
    if (lastName.length < 2) {
      return 'الإسم الأخير يجب ألا يقل عن حرفين';
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
    if (password.contains(' ')) {
      return 'لا تستخدم مسافات';
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
    if (password.contains(' ')) {
      return 'لا تستخدم مسافات';
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
    if (passwordConfirmation.contains(' ')) {
      return 'لا تستخدم مسافات';
    }
    return null;
  }

  static String? emailValidation(String? email) {
    if (email == null || email.isEmpty) {
      return 'برجاء إدخال البريد الإلكتروني';
    }
    if (email.length < 5 ||
        !RegExp(r'^[\w-]+(?:\.[\w-]+)*@(?:[\w-]+\.)+[a-zA-Z]{2,}$')
            .hasMatch(email)) {
      return 'برجاء إدخال البريد الإلكتروني بشكل صحيح';
    }

    if (email.contains(' ')) {
      return 'لا تستخدم مسافات';
    }
    return null;
  }
}

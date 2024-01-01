class MyValidators {
  static String? nameValidator(String? name) {
    if (name == null || name.isEmpty) {
      return 'Name cannot be empty';
    }
    if (name.length < 3 || name.length > 20) {
      return 'Name must be between 3 and 20 characters';
    }

    return null; // Return null if display name is valid
  }

  static String? emailValidator(String? value) {
    if (value!.isEmpty) {
      return 'Please enter an email';
    }
    if (!RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b')
        .hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value!.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  static String? repeatPasswordValidator({String? value, String? password}) {
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? addressValidator(String? value) {
    if (value!.isEmpty) {
      return 'Please enter an address';
    }
    return null;
  }

  static String? uploadProdTexts({String? value, String? toBeReturnedString}) {
    if (value!.isEmpty) {
      return toBeReturnedString;
    }
    return null;
  }

  static String? cardNumberValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a card number';
    }
    if (!RegExp(r'\b[0-9]{4} [0-9]{4} [0-9]{4} [0-9]{4}\b').hasMatch(value)) {
      return 'Please enter a valid card number';
    }
    return null;
  }

  static String? dateValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a date';
    }
    if (!RegExp(r'\b(0[1-9]|1[0-2])/2[4-9]\b').hasMatch(value)) {
      return 'Please enter a valid date';
    }
    return null;
  }

  static String? cvvValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a CVV';
    }
    if (!RegExp(r'\b[0-9]{3}\b').hasMatch(value)) {
      return 'Please enter a valid CVV';
    }
    return null;
  }
}

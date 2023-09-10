class AppValidators {
  static String? emptyTextValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter text';
    }
    return null;
  }

  static String? nameValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name cannot be empty';
    }
    String pattern = '([a-zA-Z])';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return 'Invalid Username, Only letters are allowed.';
    }
    return null;
  }

  static String? emailValidator(String? email) {
    if (email == null || email.trim().isEmpty) {
      return "Please enter email";
    }
    final bool isValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (!isValid) {
      return "Please enter valid email";
    }
    return null;
  }

  static String? passwordValidator(String? pwd) {
    if (pwd == null || pwd.trim().isEmpty) {
      return "Please enter password";
    }
    if (pwd.length < 6) {
      return "Password should be minimum length of 6 characters.";
    }
    return null;
  }

  static String? confirmPasswordValidator(
      {String? actualPass, String? anotherPass}) {
    if (actualPass == null || actualPass.trim().isEmpty) {
      return "Please enter password";
    }
    if (actualPass.length < 6) {
      return "Password should be minimum length of 6 characters.";
    }
    if (actualPass != anotherPass) {
      return "Passwords are not same.";
    }
    return null;
  }
}

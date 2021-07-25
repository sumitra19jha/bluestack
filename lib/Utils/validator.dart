class Validator {
  static String? validatePhone(String phone) {
    if (phone.isEmpty) {
      return "Phone number must not be left blank";
    }
    const String pattern = r"^(?:[+0]9)?[0-9]{10}$";
    final RegExp regex = RegExp(pattern);

    if (phone.length != 10) {
      return 'Phone Number must be 10 digits long';
    }

    if (!regex.hasMatch(phone)) {
      return 'Please enter a valid Phone Number';
    }

    return null;
  }

  static String? validatePassword(String password) {
    // If password is empty return.
    if (password.isEmpty) {
      return "Password must not be left blank";
    }

    //Regex for no spaces allowed
    const String noSpaces = r'^\S+$';
    final RegExp noSpaceRegex = RegExp(noSpaces);

    if (!noSpaceRegex.hasMatch(password)) {
      return "Password must not contain spaces";
    }

    if (password != "password123") {
      return "Wrong Credentials, Try Again";
    }

    return null;
  }
}

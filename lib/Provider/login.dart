import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider with ChangeNotifier {
  late String phoneNumber;
  late String userPassword;
  late bool isLogged = false;

  bool get isUserAlreadyLogged {
    return isLogged;
  }

  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    final String? isUserLogged = prefs.getString('isLogged');
    if (isUserLogged == "true") {
      isLogged = true;
      notifyListeners();
    }
  }

  Future<void> login(String phone, String password) async {
    if (phone == "9898989898" || phone == "9876543210") {
      phoneNumber = phone;
    } else {
      throw ("Invalid Phone Number");
    }

    if (password == "password123") {
      userPassword = password;
    } else {
      throw ("Invalid Password");
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('isLogged', 'true');
  }
}

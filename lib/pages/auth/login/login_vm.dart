import 'package:flutter/material.dart';
import 'package:mvvm/util/extention.dart';

class LoginVM extends ChangeNotifier {
  String? _email;
  String? _password;

  bool get isDone =>
      !_email.isNullOrEmpty &&
      !_password.isNullOrEmpty &&
      emailValid == null &&
      passwordValid == null;
  String? get emailValid => _emailValidate(_email);
  String? get passwordValid => _passwordValidate(_password);
  void setEmail(String? email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String? password) {
    _password = password;
    notifyListeners();
  }

  String? _emailValidate(String? email) {
    if (email != null) {
      bool rex = RegExp(
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
          .hasMatch(email);

      return rex ? null : "Lütfen geçerli bir e-posta adresi giriniz.";
    }
    return null;
  }

  String? _passwordValidate(String? password) {
    if (password != null && password.length >= 6) {
      bool rex = RegExp(r"^(?=.*\d)(?=.*[a-zA-Z]).{6,}$").hasMatch(password);

      return rex
          ? null
          : "Şifreniz en az 6 karakterden oluşmalı, en az 1 harf ve en az 1 rakam içermelidir.";
    }
    return null;
  }
}

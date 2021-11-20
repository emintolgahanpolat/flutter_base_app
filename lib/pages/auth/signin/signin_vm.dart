import 'package:flutter/material.dart';
import 'package:mvvm/util/extention.dart';

class SignInVM extends ChangeNotifier {
  String? _name;
  String? _phone;
  String? _email;
  bool? _isPhone;
  bool? get isPhone => _isPhone;

  void phoneOrMail(bool? flag) {
    _isPhone = flag;
    notifyListeners();
  }

  bool get isDone => false;
  bool? get nameValid => _name.isNull ? null : !_name.isNullOrEmpty;

  String? get _emailValidate => _emailValidating(_email);
  bool? get _emailValid =>
      _email.isNull ? null : _emailValidating(_email).isNull;

  String? get _phoneValidate => _phoneValidating(_phone);
  bool? get _phoneValid =>
      _phone.isNull ? null : _phoneValidating(_phone).isNull;

  String? get phoneOrMailValidate =>
      _isPhone! ? _phoneValidate : _emailValidate;
  bool? get phoneOrMailValid => _isPhone! ? _phoneValid : _emailValid;

  void setName(String? name) {
    _name = name;
    notifyListeners();
  }

  void setEmail(String? email) {
    _email = email;
    notifyListeners();
  }

  void setPhone(String? phone) {
    _phone = phone;
    notifyListeners();
  }

  String? _emailValidating(String? email) {
    if (email != null) {
      bool rex = RegExp(
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
          .hasMatch(email);

      return rex ? null : "Lütfen geçerli bir e-posta adresi giriniz.";
    }
    return null;
  }

  String? _phoneValidating(String? name) {
    if (name != null && name.isNotEmpty) {
      bool rex = RegExp(r"^(?=.*\d)(?=.*[a-zA-Z]).{6,}$").hasMatch(name);

      return rex
          ? null
          : "Şifreniz en az 6 karakterden oluşmalı, en az 1 harf ve en az 1 rakam içermelidir.";
    }
    return null;
  }
}

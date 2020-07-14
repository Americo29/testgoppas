import 'package:flutter/services.dart';

class Utils {
  static const String emailRegExpString =
      r'[a-zA-Z0-9\+\.\_\%\-\+]{1,256}\@[a-zA-Z0-9][a-zA-Z0-9\-]{0,64}(\.[a-zA-Z0-9][a-zA-Z0-9\-]{0,25})+';
  static RegExp emailRegExp = RegExp(emailRegExpString, caseSensitive: false);
  static const phonePattern = r'(^(?:[+0]9)?[0-9]{10}$)';
  static RegExp phoneregExp = RegExp(phonePattern, caseSensitive: false);

  static const cedulaPattern = r'(^(?:[+0]9)?[0-9]{8,10}$)';
  static RegExp cedulaRegExp = RegExp(cedulaPattern, caseSensitive: false);

  static const namePattern =
      r'(^[a-zA-ZÀ-ÿ\00f100d1]+(\s*[a-zA-ZÀ-ÿ00f1\00d1]*)*[a-zA-ZÀ-ÿ\00f1\00d1]+$)';
  static RegExp nameRegExp = RegExp(namePattern, caseSensitive: false);

  static const textPattern = r'(^[a-zA-Z0-9\+\.\ \_\%\-\+]{6}$)';
  static RegExp textRegExp = RegExp(textPattern, caseSensitive: false);

  static const balancePattern =
      r'(^(0|([1-9][0-9]{0,3}))(.[0-9]{0,3})([0-9].[0-9]{0,3})?$)';
  static RegExp balanceregExp = RegExp(balancePattern, caseSensitive: false);

  bool validateEmail(String email) {
    return emailRegExp.hasMatch(email);
  }

  bool validateName(String name) {
    return nameRegExp.hasMatch(name);
  }

  bool validateText(String text) {
    return textRegExp.hasMatch(text);
  }

  bool validatePhone(String phone) {
    bool flag;
    if (phone.length == 0) {
      flag = false;
    } else {
      flag = phoneregExp.hasMatch(phone);
    }
    return flag;
  }

  bool validateCedula(String cedula) {
    bool flag;
    if (cedula.length == 0) {
      flag = false;
    } else {
      flag = cedulaRegExp.hasMatch(cedula);
    }
    return flag;
  }

  bool validateNumber(String balance) {
    bool flag;
    if (balance.length == 0) {
      flag = false;
    } else {
      flag = balanceregExp.hasMatch(balance);
    }
    return flag;
  }
}

final utils = Utils();

import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  var _mobileNumber;
  var _employeeNo;
  int _otp = 0;
  var _userId;
  String _name = '';

  String _email = '';

  int get otp => _otp;
  get employeeNo => _employeeNo;
  get userId => _userId;
  get mobileNumber => _mobileNumber;

  get name => _name;
  get email => _email;

  void updateVariables({mobileNumber, employeeNo, userId, otp, email, name}) {
    if (mobileNumber != null) {
      _mobileNumber = mobileNumber;
    }
    if (employeeNo != null) {
      _employeeNo = employeeNo;
    }
    if (userId != null) {
      _userId = userId;
    }
    if (otp != null) {
      _otp = otp;
      ;
    }
    if (email != null) {
      _email = email;
    }
    if (name != null) {
      _name = name;
    }
    notifyListeners();
  }
}

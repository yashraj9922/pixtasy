import 'package:flutter/material.dart';
import 'package:pixtasy/models/user.dart';
import 'package:pixtasy/resources/auth_methods.dart';

class UserProvider extends ChangeNotifier {
  User? _user;
  final AuthMethods _authMethods = AuthMethods();

  // acessing private member variable _user
  User get getUser => _user!;

  Future<void> refreshUser() async {
    // function to update values of users
    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}

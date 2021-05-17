import 'package:flutter/widgets.dart';
import 'package:skype_clone/models/user.dart';
import 'package:skype_clone/resources/auth_methos.dart';

class UserProvider with ChangeNotifier {

  AuthMethods _authMethods = AuthMethods();
  UserModel _userModel;

  UserModel get getUser => _userModel;

  Future<void> refreshUser() async {
    UserModel user = await _authMethods.getUserDetails();
    _userModel = user;
    notifyListeners();
  }

}
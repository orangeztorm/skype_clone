import 'package:flutter/widgets.dart';
import 'package:skype_clone/models/user.dart';
import 'package:skype_clone/resources/auth_methos.dart';

class UserProvider with ChangeNotifier {

  AuthMethods _authMethods = AuthMethods();
  UserModel _user;

  UserModel get getUser => _user;

  Future<void> refreshUser() async {
    UserModel user = await _authMethods.getUserDetails();
    _user = user;
    print('provider ${user.uid}');
    notifyListeners();
  }

}
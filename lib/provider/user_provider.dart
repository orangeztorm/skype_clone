import 'package:flutter/widgets.dart';
import 'package:skype_clone/models/user.dart';
import 'package:skype_clone/resources/firebase_repository.dart';

class UserProvider with ChangeNotifier {
  UserModel _userModel;
  FirebaseRepository _firebaseRepository = FirebaseRepository();

  UserModel get getUser => _userModel;

  Future<void> refreshUser() async {
    UserModel user = await _firebaseRepository.getUserDetails();
    _userModel = user;
    notifyListeners();
  }

}
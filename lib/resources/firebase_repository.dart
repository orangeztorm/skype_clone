import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:skype_clone/models/message.dart';
import 'package:skype_clone/models/user.dart';
import 'package:skype_clone/resources/firebase_methods.dart';

class FirebaseRepository{
 FirebaseMethods _firebaseMethods = FirebaseMethods();

 Future<User> getCurrentUser()async => _firebaseMethods.getCurrentUser();

 Future<UserCredential> signIn() => _firebaseMethods.signIn();

 Future<bool> authenticateUser(User user) => _firebaseMethods.authenticateUser(user);

 Future<void> addDataToDb(User user) => _firebaseMethods.addDataToDb(user);

 // responsible for signin out
 Future<void> signOut() => _firebaseMethods.signOut();

 Future<List<UserModel>> fetchAllUsers(User user) => _firebaseMethods.fetchAllUsers(user);

 Future<void> addMessageToDb(Message message, UserModel sender, UserModel receiver) => _firebaseMethods.addMessageToDb(message, sender ,receiver);
}
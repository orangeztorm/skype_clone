import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:skype_clone/resources/firebase_methods.dart';

class FirebaseRepository{
 FirebaseMethods _firebaseMethods = FirebaseMethods();

 Future<User> getCurrentUser()async => _firebaseMethods.getCurrentUser();

 Future<UserCredential> signIn() => _firebaseMethods.signIn();

 Future<bool> authenticateUser(User user) => _firebaseMethods.authenticateUser(user);

 Future<void> addDataToDb(User user) => _firebaseMethods.addDataToDb(user);

 // responsible for signin out
 Future<void> signOut() => _firebaseMethods.signOut();
}
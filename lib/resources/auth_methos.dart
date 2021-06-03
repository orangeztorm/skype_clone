import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:skype_clone/constants/strings.dart';
import 'package:skype_clone/enum/user_state.dart';
import 'package:skype_clone/models/user.dart';
import 'package:skype_clone/utils/utilities.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<User> getCurrentUser() async {
    User currentUser;
    currentUser = _auth.currentUser;
    return currentUser;
  }

  Future<UserModel> getUserDetails() async {
    User currentUser = await getCurrentUser();
    print(currentUser.uid);
    DocumentSnapshot documentSnapshot = await firestore
        .collection('USERS_COLLECTION')
        .doc(currentUser.uid)
        .get();
    if (documentSnapshot.exists) {
      print(true);
      UserModel user = UserModel.fromMap(documentSnapshot.data());
      print('get  user details ${user.uid}');
      return user;
    } else {
      print('no');
    }
  }

  Future<UserModel> getUserDetailsId(id) async {
    try {
      DocumentSnapshot documentSnapshot =
          await firestore.collection('USERS_COLLECTION').doc(id).get();
      return UserModel.fromMap(documentSnapshot.data());
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<User> signIn() async {
    try {
      GoogleSignInAccount _signInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication _signInuthentication =
          await _signInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: _signInuthentication.accessToken,
        idToken: _signInuthentication.idToken,
      );

      UserCredential user = await _auth.signInWithCredential(credential);
      return user.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> authenticateUser(User user) async {
    QuerySnapshot result = await firestore
        .collection(USERS_COLLECTION)
        .where(EMAIL_FIELD, isEqualTo: user.email)
        .get();
    final List<DocumentSnapshot> docs = result.docs;
    // if user document is 0 then he is registered
    return docs.length == 0 ? true : false;
  }

  Future<void> addDataToDb(User currentUser) async {
    print(' current user uid ${currentUser.uid}');
    String userName = Utils.getUserName(currentUser.email);
    UserModel userModel = UserModel(
        uid: currentUser.uid,
        email: currentUser.email,
        name: currentUser.displayName,
        profilePhoto: currentUser.photoURL,
        username: userName);
    firestore
        .collection('USERS_COLLECTION')
        .doc(currentUser.uid)
        .set(userModel.toMap(userModel));
  }

  Future<List<UserModel>> fetchAllUsers(User currentUser) async {
    List<UserModel> userList = List<UserModel>();
    QuerySnapshot querySnapshot =
        await firestore.collection('USERS_COLLECTION').get();
    print(querySnapshot.docs);
    for (var i = 0; i < querySnapshot.docs.length; i++) {
      if (querySnapshot.docs[i].id != currentUser.uid) {
        userList.add(UserModel.fromMap(querySnapshot.docs[i].data()));
      }
    }
    return userList;
  }

  Future<bool> signOut() async {
    try {
      await _googleSignIn.disconnect();
      await _googleSignIn.signOut();
      await _auth.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }

  void setUserState({String userId, UserState userState}) {
    int stateNum = Utils.stateToNum(userState);
    firestore
        .collection('USERS_COLLECTION')
        .doc(userId)
        .update({"state": stateNum});
  }

  Stream<DocumentSnapshot> getUserStream({String uid}) =>
      firestore.collection('USERS_COLLECTION').doc(uid).snapshots();
}

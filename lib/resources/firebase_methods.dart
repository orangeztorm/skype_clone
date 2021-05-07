import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:skype_clone/models/user.dart';
import 'package:skype_clone/utils/utilities.dart';

class FirebaseMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  UserModel userModel = UserModel();

  Future<User> getCurrentUser() async {
    User currentUser;
    currentUser = await _auth.currentUser;
    return currentUser;
  }

  Future<UserCredential> signIn() async {
    GoogleSignInAccount _signInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication _signInuthentication =
    await _signInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: _signInuthentication.accessToken,
      idToken: _signInuthentication.idToken,
    );

    return await _auth.signInWithCredential(credential);
  }

  Future<bool> authenticateUser(User user) async {
    QuerySnapshot result = await firestore.collection("users ").where(
        "email", isEqualTo: user.email).get();
    final List<DocumentSnapshot> docs = result.docs;
    // if user document is 0 then he is registered
    return docs.length == 0 ? true : false;
  }

  Future<void> addDataToDb(User currentUser) async {
    print(currentUser);
    String userName = Utils.getUserName(currentUser.email);
    userModel = UserModel(
        uid: currentUser.uid,
        email: currentUser.email,
        name: currentUser.displayName,
        profilePhoto: currentUser.photoURL,
        username: userName
    );
    print('passed');
    firestore.collection('users').doc(currentUser.uid).set(
        userModel.toMap(userModel));
  }

  Future<void> signOut() async {
    await _googleSignIn.disconnect();
    await _googleSignIn.signOut();
    return await _auth.signOut();
  }
  Future<List<UserModel>> fetchAllUsers(User currentUser)async{
    List<UserModel> userList = List<UserModel>();
    QuerySnapshot querySnapshot = await firestore.collection('users').get();
    try{
      for (var i =0; 1<querySnapshot.docs.length; i++){
        if(querySnapshot.docs[i].id != currentUser.uid){
          userList.add(UserModel.fromMap(querySnapshot.docs[i].data()));

        }
      }
    }catch(e){
      print('this is the error $e');
    }

    return userList;
  }
}

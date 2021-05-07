import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skype_clone/resources/firebase_repository.dart';
import 'package:skype_clone/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseRepository _repository = FirebaseRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loginButton(),
    );
  }

  Widget loginButton(){
    return FlatButton(
      padding: EdgeInsets.all(35),
      child: Text(
        'LOGIN',
        style: TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 35,
          letterSpacing: 1.2
        )
      ),
      onPressed: () => performLogin(),);
  }

  void performLogin(){
    _repository.signIn().then((UserCredential user) => {
      if(user != null){
        authenticateUser(user.user)
      }else{
        'there was an error'
    }
    });
  }

  void authenticateUser(User user){
    _repository.authenticateUser(user).then((value) {
      if(value){
        _repository.addDataToDb(user).then((value) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
            return HomeScreen();
          }));
        });
      } else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
          return HomeScreen();
        }));
      }
    });
  }
}

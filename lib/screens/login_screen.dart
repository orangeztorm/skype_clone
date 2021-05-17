import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skype_clone/resources/auth_methos.dart';
import 'package:skype_clone/screens/home_screen.dart';
import 'package:skype_clone/utils/universal_variables.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoginPressed = false;
  final AuthMethods _authMethods = AuthMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UniversalVariables.blackColor,
      body: Stack(children: [
        Center(child: loginButton()),
        isLoginPressed ? Center(child: CircularProgressIndicator(),): Container()
      ]),
    );
  }

  Widget loginButton() {
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: UniversalVariables.senderColor,
      child: FlatButton(
        padding: EdgeInsets.all(35),
        child: Text('LOGIN',
            style: TextStyle(
                fontWeight: FontWeight.w900, fontSize: 35, letterSpacing: 1.2)),
        onPressed: () => performLogin(),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void performLogin() {
    setState(() {
      isLoginPressed = true;
    });
    _authMethods.signIn().then((UserCredential user) => {
          if (user != null)
            {authenticateUser(user.user)}
          else
            {'there was an error'}
        });
  }

  void authenticateUser(User user) {
    _authMethods.authenticateUser(user).then((value) {
      setState(() {
        isLoginPressed = false;
      });
      if (value) {
        _authMethods.addDataToDb(user).then((value) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return HomeScreen();
          }));
        });
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return HomeScreen();
        }));
      }
    });
  }
}

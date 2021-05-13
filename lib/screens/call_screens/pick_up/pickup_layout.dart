import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skype_clone/models/call.dart';
import 'package:skype_clone/provider/user_provider.dart';
import 'package:skype_clone/resources/call_methods.dart';
import 'package:skype_clone/screens/call_screens/pick_up/pickup_screen.dart';

class PickUpLayout extends StatefulWidget {
  final Widget scaffold;

  const PickUpLayout({Key key, this.scaffold}) : super(key: key);

  @override
  _PickUpLayoutState createState() => _PickUpLayoutState();
}

class _PickUpLayoutState extends State<PickUpLayout> {
  final CallMethods callMethods = CallMethods();

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return (userProvider!= null && userProvider.getUser != null) ? StreamBuilder<DocumentSnapshot>(
      stream: callMethods.callStream(uid:   userProvider.getUser.uid),
      builder: (context, snapshot) {
        if(snapshot.hasData && snapshot.data.data() != null){
          Call call = Call.fromMap(snapshot.data.data());
          if(!call.hasDialled){
            return PickUpScreen(call: call,);
          }
          return widget.scaffold;
        }
        return widget.scaffold;
      },
    ) : Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:skype_clone/models/call.dart';
import 'package:skype_clone/resources/call_methods.dart';
import 'package:skype_clone/screens/chatscreens/widgets/cached_image.dart';

import '../call_screen.dart';

class PickUpScreen extends StatefulWidget {
  final Call call;

  const PickUpScreen({Key key, this.call}) : super(key: key);

  @override
  _PickUpScreenState createState() => _PickUpScreenState();
}

class _PickUpScreenState extends State<PickUpScreen> {
  final CallMethods callMethods = CallMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 100),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Incoming...",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(height: 50),
                  CachedImage(
                    widget.call.callerPic,
                    isRound: true,
                    radius: 180,
                  ),
                  SizedBox(height: 15),
                  Text(
                    widget.call.callerName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 75),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.call_end),
                        color: Colors.redAccent,
                        onPressed: () async {
                          // isCallMissed = false;
                          // addToLocalStorage(callStatus: CALL_STATUS_RECEIVED);
                          await callMethods.endCall(call: widget.call);
                        },
                      ),
                      SizedBox(width: 25),
                      IconButton(
                          icon: Icon(Icons.call),
                          color: Colors.green,
                          onPressed: () async {
                            // isCallMissed = false;
                            // addToLocalStorage(callStatus: CALL_STATUS_RECEIVED);
                            // await Permissions.cameraAndMicrophonePermissionsGranted()
                            //     ?
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CallScreen(call: widget.call),
                              ),
                            );
                                // : {};
                          }),
                    ],
                  )
                ])));
  }
}

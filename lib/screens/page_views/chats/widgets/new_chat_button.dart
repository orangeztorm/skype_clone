import 'package:flutter/material.dart';
import 'package:skype_clone/utils/universal_variables.dart';

class NewChatButton extends StatelessWidget {
  const NewChatButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: UniversalVariables.fabGradient,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Center(
        child: Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
    );
  }
}

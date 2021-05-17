
import 'package:flutter/material.dart';
import 'package:skype_clone/utils/universal_variables.dart';
import 'package:skype_clone/widgets/custom_tile.dart';

class ContactView extends StatelessWidget {
  const ContactView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTile(
      mini: false,
      onTap: () {},
      title: Text(
        "Taiwo Kenny",
        style: TextStyle(
            color: Colors.white,
            fontFamily: "Arial",
            fontSize: 19
        ),
      ),
      subtitle:  Text(
        "Hello",
        style: TextStyle(
            color: UniversalVariables.greyColor,
            fontSize: 14
        ),
      ),
      leading: Container(
        constraints: BoxConstraints(maxHeight: 60, maxWidth: 60),
        child: Stack(
          children: [
            CircleAvatar(
              maxRadius: 30,
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage('https://miro.medium.com/max/4090/1*lRu8OA8Kjc6luPKMQajYmQ.jpeg'),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(height: 15,width: 15,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: UniversalVariables.onlineDotColor,
                    border: Border.all(
                        color: UniversalVariables.blackColor,
                        width: 2
                    )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

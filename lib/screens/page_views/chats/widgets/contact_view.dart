
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skype_clone/models/contact.dart';
import 'package:skype_clone/models/user.dart';
import 'package:skype_clone/provider/user_provider.dart';
import 'package:skype_clone/resources/auth_methos.dart';
import 'package:skype_clone/resources/chat_methods.dart';
import 'package:skype_clone/screens/chatscreens/chat_screen.dart';
import 'package:skype_clone/screens/chatscreens/widgets/cached_image.dart';
import 'package:skype_clone/screens/page_views/chats/chat_list_screen.dart';
import 'package:skype_clone/utils/universal_variables.dart';
import 'package:skype_clone/widgets/custom_tile.dart';

import 'last_message_container.dart';
import 'online_dot_indicator.dart';

class ContactView extends StatelessWidget {
  ContactView({Key key, this.contact}) : super(key: key);
  final Contact contact;
  final AuthMethods _authMethods = AuthMethods();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel>(
      future: _authMethods.getUserDetailsId(contact.uid),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          UserModel user = snapshot.data;
          return ViewLayout(contacts: user,);
        }
        return Center(child: CircularProgressIndicator(),);
      },
    );
  }
}

class ViewLayout extends StatelessWidget {
  ViewLayout({Key key, this.contacts}) : super(key: key);

  final UserModel contacts;
  final ChatMethods _chatMethods = ChatMethods();


  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return CustomTile(
      mini: false,
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> ChatScreen(receiver:  contacts,))),
      title: Text(
        contacts?.name ?? "..",
        style: TextStyle(
            color: Colors.white,
            fontFamily: "Arial",
            fontSize: 19
        ),
      ),
      subtitle:  LastMessageContainer(stream: _chatMethods.fetchLastMessagesBetween(
        senderId: userProvider.getUser.uid,
        receiverId: contacts.uid
      ),),
      leading: Container(
        constraints: BoxConstraints(maxHeight: 60, maxWidth: 60),
        child: Stack(
          children: [
            CachedImage(
              contacts.profilePhoto,
              radius: 80,
              isRound: true,
            ),
            OnlineDotIndicator(uid: contacts.uid)
          ],
        ),
      ),
    );
  }
}


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skype_clone/models/contact.dart';
import 'package:skype_clone/provider/user_provider.dart';
import 'package:skype_clone/resources/auth_methos.dart';
import 'package:skype_clone/resources/chat_methods.dart';
import 'package:skype_clone/screens/call_screens/pick_up/pickup_layout.dart';
import 'package:skype_clone/screens/page_views/chats/widgets/contact_view.dart';
import 'package:skype_clone/screens/page_views/chats/widgets/new_chat_button.dart';
import 'package:skype_clone/widgets/quiet_box.dart';
import 'package:skype_clone/screens/page_views/chats/widgets/user_circle.dart';
import 'package:skype_clone/utils/universal_variables.dart';
import 'package:skype_clone/utils/utilities.dart';
import 'package:skype_clone/widgets/customAppBar.dart';
import 'package:skype_clone/widgets/custom_tile.dart';
import 'package:skype_clone/widgets/skpe_appbar.dart';

class ChatListScreen extends StatelessWidget {


  CustomAppBar customAppBar(context) {
    return CustomAppBar(
        title: UserCircle(
        ),
        actions: [
          IconButton(
            color: Colors.white,
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(context, '/search_screen');
            },
          ),
          IconButton(
            color: Colors.white,
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
        leading: IconButton(
          color: Colors.white,
          icon: Icon(Icons.notifications),
          onPressed: () {},
        ),
        centerTitle: true);
  }

  @override
  Widget build(BuildContext context) {
    return PickUpLayout(
      scaffold: Scaffold(
        backgroundColor: UniversalVariables.blackColor,
        appBar: SkypeAppBar(
          title: UserCircle(),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, "/search_screen");
              },
            ),
            IconButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(onPressed: (){},child: NewChatButton()),
        body: ChatListContainer(),
      ),
    );
  }
}



class ChatListContainer extends StatelessWidget {
  final ChatMethods _chatMethods = ChatMethods();
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: _chatMethods.fetchContacts(userId: userProvider.getUser.uid),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            var docList = snapshot.data.docs;
            if(docList.isEmpty){
              return QuietBox();
            }
            return ListView.builder(
              itemCount: docList.length,
              padding: EdgeInsets.all(10),
              itemBuilder: (context, index) {
                Contact contact = Contact.fromMap(docList[index].data());
                return ContactView(contact: contact,);
              },
            );
          }
          return Center(child: CircularProgressIndicator(),);
        }
      ),
    );
  }
}

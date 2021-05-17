import 'package:flutter/material.dart';
import 'package:skype_clone/resources/auth_methos.dart';
import 'package:skype_clone/screens/page_views/widgets/new_chat_button.dart';
import 'package:skype_clone/screens/page_views/widgets/user_circle.dart';
import 'package:skype_clone/utils/universal_variables.dart';
import 'package:skype_clone/utils/utilities.dart';
import 'package:skype_clone/widgets/customAppBar.dart';
import 'package:skype_clone/widgets/custom_tile.dart';

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
    return Scaffold(
      backgroundColor: UniversalVariables.blackColor,
      appBar: customAppBar(context),
      floatingActionButton: FloatingActionButton(child: NewChatButton()),
      body: ChatListContainer(),
    );
  }
}



class ChatListContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: 2,
        padding: EdgeInsets.all(10),
        itemBuilder: (context, index) {
          return ;
        },
      ),
    );
  }
}

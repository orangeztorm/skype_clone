import 'package:flutter/material.dart';
import 'package:skype_clone/resources/firebase_repository.dart';
import 'package:skype_clone/utils/universal_variables.dart';
import 'package:skype_clone/utils/utilities.dart';
import 'package:skype_clone/widgets/customAppBar.dart';
import 'package:skype_clone/widgets/custom_tile.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({Key key}) : super(key: key);

  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

// global
final FirebaseRepository _repository = FirebaseRepository();

class _ChatListScreenState extends State<ChatListScreen> {
  String currentUser, initials, currentUserId;

  @override
  void initState() {
    super.initState();
    _repository.getCurrentUser().then((user) => setState(() {
          currentUser = user.uid;
          currentUserId = user.uid;
          initials = Utils.getInitials(user.displayName);
        }));
  }

  CustomAppBar customAppBar(context) {
    return CustomAppBar(
        title: UserCircle(
          text: initials == null ? 'TK' : initials,
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
      body: ChatListContainer(currentUserId: currentUserId),
    );
  }
}

class UserCircle extends StatelessWidget {
  final String text;

  const UserCircle({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: UniversalVariables.separatorColor,
      ),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: UniversalVariables.lightBlueColor,
                fontSize: 13,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              height: 12,
              width: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border:
                    Border.all(color: UniversalVariables.blackColor, width: 2),
                color: UniversalVariables.onlineDotColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}

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

class ChatListContainer extends StatefulWidget {
  final String currentUserId;

  const ChatListContainer({Key key, this.currentUserId}) : super(key: key);

  @override
  _ChatListContainerState createState() => _ChatListContainerState();
}

class _ChatListContainerState extends State<ChatListContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: 2,
        padding: EdgeInsets.all(10),
        itemBuilder: (context, index) {
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
        },
      ),
    );
  }
}

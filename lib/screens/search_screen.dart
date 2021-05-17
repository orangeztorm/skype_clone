import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skype_clone/models/user.dart';
import 'package:skype_clone/resources/auth_methos.dart';
import 'package:skype_clone/utils/universal_variables.dart';
import 'package:skype_clone/widgets/custom_tile.dart';

import 'chatscreens/chat_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final AuthMethods _authMethods = AuthMethods();

  List<UserModel> userList;
  String query = '';
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _authMethods.getCurrentUser().then((user) {
      _authMethods.fetchAllUsers(user).then((list) {
        setState(() {
          userList = list;
          print(list.length);
        });
      });
    });
  }

  searchAppBar(context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 20),
        child: Padding(
          padding: EdgeInsets.only(left: 20),
          child: TextField(
            controller: searchController,
            onChanged: (val) {
              setState(() {
                query = val;
              });
            },
            cursorColor: UniversalVariables.blackColor,
            autofocus: true,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 35),
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                onPressed: () =>
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                  searchController.clear();
                }),
              ),
              border: InputBorder.none,
              hintText: "Search",
              hintStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0x88ffffff),
                  fontSize: 35),
            ),
          ),
        ),
      ),
      flexibleSpace: Container(
          decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            colors: [
              UniversalVariables.gradientColorStart,
              UniversalVariables.gradientColorEnd,
            ]),
      )),
    );
  }

  buildSuggestions(String query) {
    final List<UserModel> suggestionList = query.isEmpty
        ? []
        : userList != null
            ? userList.where((UserModel userModel) {
                String _getUsername = userModel.username.toLowerCase();
                String _query = query.toLowerCase();
                String _getName = userModel.name.toLowerCase();
                bool matchesUsername = _getUsername.contains(_query);
                bool matchesName = _getName.contains(_query);
                return (matchesUsername || matchesName);
              }).toList()
            : [];

    return ListView.builder(
      itemCount: suggestionList == null? 0:suggestionList.length,
      itemBuilder: ((context, index) {
    UserModel searchedUser = UserModel(
            uid: suggestionList[index].uid,
            profilePhoto: suggestionList[index].profilePhoto,
            name: suggestionList[index].name,
            username: suggestionList[index].username);

        return CustomTile(
          mini: false,
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatScreen(
                          receiver: searchedUser,
                        )));
          },
          // leading: CachedImage(
          //   searchedUser.profilePhoto,
          //   radius: 25,
          //   isRound: true,
          // ),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(searchedUser.profilePhoto),
            backgroundColor: Colors.grey,
          ),
          title: Text(
            searchedUser.username,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            searchedUser.name,
            style: TextStyle(color: UniversalVariables.greyColor),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UniversalVariables.blackColor,
      appBar: searchAppBar(context),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: buildSuggestions(query),
      ),
    );
  }
}

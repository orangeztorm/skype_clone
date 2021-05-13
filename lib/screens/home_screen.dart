import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skype_clone/provider/user_provider.dart';
import 'package:skype_clone/screens/call_screens/pick_up/pickup_layout.dart';
import 'package:skype_clone/screens/page_views/chat_list_screen.dart';
import 'package:skype_clone/utils/universal_variables.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController pageController;
  int _page = 0;
  double _labelFontSize = 10.0;

  UserProvider userProvider;

  @override
  void initState() {
    super.initState();
    userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.refreshUser();
    pageController = PageController();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
  pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return PickUpLayout(
      scaffold: Scaffold(
        backgroundColor: UniversalVariables.blackColor,
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            Container(child: ChatListScreen()),
            Center(child: Text("call Logs")),
            Center(child: Text("Contact Screen"))
          ],
          controller: pageController,
          onPageChanged: onPageChanged,
        ),
        bottomNavigationBar: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: CupertinoTabBar(
              backgroundColor: UniversalVariables.blackColor,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(
                  Icons.chat,
                  color: _page == 0
                      ? UniversalVariables.lightBlueColor
                      : UniversalVariables.greyColor,
                ),
                // label: ''
                  title: Text(
                    'Chats',
                    style: TextStyle(
                      fontSize: _labelFontSize,
                      color: _page == 0
                          ? UniversalVariables.lightBlueColor
                          : UniversalVariables.greyColor,
                    )
                  )
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.call,
                      color: _page == 1
                          ? UniversalVariables.lightBlueColor
                          : UniversalVariables.greyColor,
                    ),
                    // label: ''
                    title: Text(
                        'C😃all',
                        style: TextStyle(
                          fontSize: _labelFontSize,
                          color: _page == 1
                              ? UniversalVariables.lightBlueColor
                              : UniversalVariables.greyColor,
                        )
                    )
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.contact_phone,
                      color: _page == 2
                          ? UniversalVariables.lightBlueColor
                          : UniversalVariables.greyColor,
                    ),
                    // label: ''
                    title: Text(
                        'Chats',
                        style: TextStyle(
                          fontSize: _labelFontSize,
                          color: _page == 2
                              ? UniversalVariables.lightBlueColor
                              : UniversalVariables.greyColor,
                        )
                    )
                )
              ],
              onTap: navigationTapped,
              currentIndex: _page,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:skype_clone/screens/call_screens/pick_up/pickup_layout.dart';
import 'package:skype_clone/screens/page_views/logs/widgets/floating_column.dart';
import 'package:skype_clone/screens/page_views/logs/widgets/log_list_container.dart';
import 'package:skype_clone/utils/universal_variables.dart';
import 'package:skype_clone/widgets/skpe_appbar.dart';


class LogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PickUpLayout(
      scaffold: Scaffold(
        backgroundColor: UniversalVariables.blackColor,
        appBar: SkypeAppBar(
          title: "Calls",
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () => Navigator.pushNamed(context, "/search_screen"),
            ),
          ],
        ),
        floatingActionButton: FloatingColumn(),
        body: Padding(
          padding: EdgeInsets.only(left: 15),
          child: LogListContainer(),
        ),
      ),
    );
  }
}
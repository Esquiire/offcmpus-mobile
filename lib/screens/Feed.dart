import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mobile_fl/API/AuthAPI.dart';
import 'package:mobile_fl/API/GQLConfig.dart';
import 'package:mobile_fl/components/AuthWrapper.dart';
import 'package:mobile_fl/screens/Login.dart';
import 'package:mobile_fl/screens/Register.dart';
import 'package:mobile_fl/components/Input.dart';
import 'package:mobile_fl/components/Button.dart';
import 'package:mobile_fl/constants.dart';
import 'package:hive/hive.dart';

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext ctx) {
    return AuthWrapper(
        authLevel: AuthLevels.STUDENT,
        ctx: ctx,
        body: Scaffold(
          appBar: AppBar(
            title: Text("Feed"),
          ),
          drawer: Drawer(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Text('Navigation'),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                ),
                ListTile(
                  title: Text('Feed'),
                  tileColor: Constants.pink(),
                  leading: Icon(
                    Icons.dynamic_feed,
                    color: Colors.pink,
                    size: 30.0,
                  ),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
                ListTile(
                  title: Text('Search'),
                  leading: Icon(
                    Icons.search,
                    color: Colors.pink,
                    size: 30.0,
                  ),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                    Navigator.pushNamedAndRemoveUntil(
                        ctx, '/search', (r) => false);
                  },
                ),
              ],
            ),
          ),
          body: Container(
            child: Text("Welcome to the feed"),
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mobile_fl/API/AuthAPI.dart';
import 'package:mobile_fl/API/GQLConfig.dart';
import 'package:mobile_fl/API/queries/PropertyQuery.dart';
import 'package:mobile_fl/components/AuthWrapper.dart';
import 'package:mobile_fl/screens/Login.dart';
import 'package:mobile_fl/screens/Register.dart';
import 'package:mobile_fl/components/Input.dart';
import 'package:mobile_fl/components/Button.dart';
import 'package:mobile_fl/constants.dart';
import 'package:hive/hive.dart';
import 'package:mobile_fl/main.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  dynamic box;
  _SearchScreenState() {
    Hive.openBox('appState').then((_box) {
      setState(() {
        this.box = _box;
      });
    }).catchError((e) {
      print(e);
    });
    GraphQLClient client = gqlConfiguration.clientToQuery();
    client
        .query(QueryOptions(
            document: gql(PropertyQuery.searchForProperty(0, 1000, 2, 1000))))
        .then((QueryResult result) {
      debugPrint("Result Received!");
    }).catchError((e) {
      print(e);
    });
  }
  @override
  Widget build(BuildContext ctx) {
    return AuthWrapper(
      authLevel: AuthLevels.STUDENT,
      ctx: ctx,
      body: Scaffold(
        appBar: AppBar(
          title: Text("Search"),
        ),
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: box == null
                    ? Text("null")
                    : Text(box.get('student').firstName +
                        " " +
                        box.get('student').lastName),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                title: Text('Feed'),
                leading: Icon(
                  Icons.dynamic_feed,
                  color: Colors.pink,
                  size: 30.0,
                ),
                onTap: () {
                  // Update the state of the app.
                  // ...
                  Navigator.pushNamedAndRemoveUntil(ctx, '/feed', (r) => false);
                },
              ),
              ListTile(
                title: Text('Search'),
                tileColor: Constants.pink(),
                leading: Icon(
                  Icons.search,
                  color: Colors.pink,
                  size: 30.0,
                ),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
            ],
          ),
        ),
        body: Container(
            margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Column(children: [
              Expanded(
                  flex: 1,
                  child: Column(
                    children: [],
                  )),
            ])),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mobile_fl/API/AuthAPI.dart';
import 'package:mobile_fl/API/GQLConfig.dart';
import 'package:mobile_fl/API/queries/PropertyQuery.dart';
import 'package:mobile_fl/components/AuthWrapper.dart';
import 'package:mobile_fl/components/PropertyCard.dart';
import 'package:mobile_fl/screens/Login.dart';
import 'package:mobile_fl/screens/Register.dart';
import 'package:mobile_fl/components/Input.dart';
import 'package:mobile_fl/components/Button.dart';
import 'package:mobile_fl/components/PropertyCard.dart';
import 'package:mobile_fl/constants.dart';
import 'package:hive/hive.dart';
import 'package:mobile_fl/main.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:expandable/expandable.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  dynamic box;
  _SearchScreenState() {
    // open the appState box
    // Hive.openBox('appState').then((_box) {
    //   setState(() {
    //     this.box = _box;
    //   });
    // }).catchError((e) {
    //   print(e);
    // });

    // get the gql client
    // GraphQLClient client = gqlConfiguration.clientToQuery();

    // query for the search results
    // client
    //     .query(QueryOptions(
    //         document: gql(PropertyQuery.searchForProperty(0, 1000, 2, 1000))))
    //     .then((QueryResult result) {
    //   debugPrint("Result Received!");
    // }).catchError((e) {
    //   print(e);
    // });
  }
  RangeValues _currentRangeValues = const RangeValues(0, 500);
  bool param_changing = false;
  @override
  Widget build(BuildContext ctx) {
    return AuthWrapper(
        authLevel: AuthLevels.STUDENT,
        ctx: ctx,
        body: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Text("Search"),
              bottom: TabBar(
                tabs: [
                  Tab(
                    text: "Feed",
                  ),
                  Tab(
                    text: "Search",
                  )
                ],
              ),
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
                      Navigator.pushNamedAndRemoveUntil(
                          ctx, '/feed', (r) => false);
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
                        children: [
                          Container(
                              child: RangeSlider(
                            values: _currentRangeValues,
                            min: 0,
                            max: 1000,
                            divisions: 10,
                            labels: RangeLabels(
                              _currentRangeValues.start.round().toString(),
                              _currentRangeValues.end.round().toString(),
                            ),
                            onChanged: (RangeValues values) {
                              setState(() {
                                _currentRangeValues = values;
                              });
                            },
                            onChangeStart: (RangeValues start) {
                              setState(() {
                                param_changing = true;
                              });
                            },
                            onChangeEnd: (RangeValues end) {
                              setState(() {
                                param_changing = false;
                              });
                            },
                          )),
                          Container(
                              child: param_changing == false
                                  ? Query(
                                      options: QueryOptions(
                                          document: gql(PropertyQuery
                                              .searchForPropertyGQL()),
                                          variables: {
                                            "price_start": 0,
                                            "price_end": 0,
                                            "rooms": 6,
                                            "distance": 1000
                                          } // ???
                                          ),
                                      builder: (QueryResult result,
                                          {VoidCallback refetch,
                                          FetchMore fetchMore}) {
                                        if (result.hasException)
                                          return Text(
                                              result.exception.toString());
                                        if (result.isLoading)
                                          return Text("Loading");
                                        //return Text("Loaded!");
                                        List<Object> propertyResults =
                                            result.data["searchForProperties"]
                                                ["data"]["search_results"];
                                        if (propertyResults.length == 0)
                                          return Text(
                                              "No results for given param");
                                        return Expanded(
                                            child: ListView.separated(
                                          itemCount: propertyResults.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return PropertyCard(result.data[
                                                        "searchForProperties"]
                                                    ["data"]["search_results"]
                                                [index]);
                                          },
                                          separatorBuilder:
                                              (BuildContext context,
                                                      int index) =>
                                                  const Divider(
                                            color: Colors.white,
                                          ),
                                        ));
                                      },
                                    )
                                  : Container(
                                      child:
                                          Expanded(child: Text("waiting...")),
                                    ))
                        ],
                      )),
                ])),
          ),
        ));
  }
}

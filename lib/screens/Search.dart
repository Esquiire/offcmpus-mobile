import 'dart:math';

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
import 'package:mobile_fl/screens/UserAccessBottomNavContainer.dart';
import 'package:numberpicker/numberpicker.dart';

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

  void goToFilters(BuildContext ctx) {
    // navigate to the filters screen
    Navigator.of(ctx)
        .push(MaterialPageRoute(builder: (context) => FilterScreen()));
  }

  @override
  Widget build(BuildContext ctx) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Expanded(
                  child: Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Filter"),
                    Text(
                      "3 Filters Applied",
                      style: TextStyle(color: Constants.pink(), fontSize: 12),
                    )
                  ],
                ),
              )),
              GestureDetector(
                onTap: () => goToFilters(ctx),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          left: BorderSide(
                              width: 1, color: Constants.navy(opacity: 0.3)))),
                  // constraints: BoxConstraints.tightFor(height: 40),
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Text(
                    "ADD FILTERS",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                  ),
                ),
              )
            ],
          ),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: Constants.navy(opacity: 0.3), width: 1))),
        ),
        Expanded(child: ListView(children: (() {
          List<Widget> properties = [];
          for (int i = 0; i < 10; ++i) properties.add(NewPropertyCard());
          return properties;
        })()))
      ],
    );
  }
}

class NewPropertyCard extends StatefulWidget {
  @override
  _NewPropertyCardState createState() => _NewPropertyCardState();
}

class _NewPropertyCardState extends State<NewPropertyCard> {
  @override
  Widget build(BuildContext ctx) => Container(
        child: Stack(
          children: [
            Positioned(
                child: Text(
                  "\$300-600 /month",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                right: 10,
                top: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Text 1 Sample",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("Troy NY, 12180")
                    ],
                  ),
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Row(children: (() {
                      List<String> tagStrs = ["Furnished", "Washer", "Heating"];
                      List<Widget> tags = [];

                      for (int i = 0; i < tagStrs.length; ++i) {
                        tags.add(Container(
                          child:
                              Text(tagStrs[i], style: TextStyle(fontSize: 10)),
                          padding: EdgeInsets.fromLTRB(6, 4, 6, 4),
                          margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                          decoration: BoxDecoration(
                              color: Constants.navy(opacity: 0.12),
                              borderRadius: BorderRadius.circular(3)),
                        ));
                      }

                      return tags;
                    })())),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  decoration: BoxDecoration(),
                  constraints: BoxConstraints.expand(height: 100),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: (() {
                      List<Widget> imageHolderCards = [];

                      for (int i = 0; i < 10; ++i) {
                        imageHolderCards.add(Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color.fromRGBO(
                                    Random().nextInt(256),
                                    Random().nextInt(256),
                                    Random().nextInt(256),
                                    1.0)),
                            margin:
                                EdgeInsets.fromLTRB(i == 0 ? 10 : 0, 0, 10, 0),
                            constraints: BoxConstraints.tightFor(
                              width: (Random().nextDouble() * 150) + 100,
                              height: 100,
                            )));
                      }
                      return imageHolderCards;
                    })(),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Text("Roe Jogan / 10 Photos / 4 Reviews",
                      style: TextStyle(fontSize: 12)),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: RatingsComponent(RatingsComponent.TYPE_LANDLORD),
                      ),
                      Expanded(
                        flex: 1,
                        child: RatingsComponent(RatingsComponent.TYPE_PROPERTY),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      );
}

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  void _selectDate(BuildContext ctx, String type) async // "end")
  {
    // type == "start" | "end"
    DateTime start = DateTime.now();
    // set end to 5 years in future
    DateTime end = new DateTime(start.year + 5, start.month, start.day);
    // TODO set initialDate to be the currently selected date, if one is selcted, or DateTime.now() otherwise

    final DateTime dtPicked = await showDatePicker(
        context: ctx,
        initialDate: DateTime.now(),
        firstDate: start,
        lastDate: end);
    print("DT Picked => $dtPicked");
  }

  @override
  Widget build(BuildContext ctx) => Scaffold(
      body: AuthWrapper(
          ctx: ctx,
          authLevel: AuthLevels.STUDENT,
          body: Column(
            children: [
              AppHeader(
                "Search Filter",
                mode: AppHeader.MODE_BACK,
                parentCtx: ctx,
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                      // TODO make button w/ more-info modal or something...
                      child: Button(
                        text: "Auto-Apply Search Status",
                        backgroundColor: Constants.grey(),
                        textColor: Constants.navy(),
                      ),
                    ),
                    Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Price Range",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            RangeSlider(
                                activeColor: Constants.pink(),
                                inactiveColor: Constants.grey(),
                                min: 300,
                                max: 1000,
                                values: const RangeValues(400, 500),
                                onChanged: (RangeValues values) {
                                  // TODO update price range on change
                                })
                          ],
                        )),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              "Number of Rooms",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          ),
                          NumberPicker(
                              axis: Axis.horizontal,
                              minValue: 1,
                              maxValue: 4,
                              value: 1,
                              onChanged: (value) {
                                // TODO update number of rooms on change
                              })
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Lease Start / End Date",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Button(
                              text: "Select Start Date",
                              backgroundColor: Constants.grey(),
                              textColor: Constants.navy(),
                              onPress: () => _selectDate(ctx, "start"),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Button(
                              text: "Select End Date",
                              backgroundColor: Constants.grey(),
                              textColor: Constants.navy(),
                              onPress: () => _selectDate(ctx, "end"),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Button(
                  text: "Apply Filters",
                  backgroundColor: Constants.pink(),
                  textColor: Colors.white,
                  onPress: () {
                    print("TODO Apply Filters!");
                    // navigate back to search page
                    Navigator.pop(ctx);
                  },
                ),
              )
            ],
          )));
}

class RatingsComponent extends StatelessWidget {
  static const int TYPE_LANDLORD = 1;
  static const int TYPE_PROPERTY = 2;

  int ratingType;

  RatingsComponent(this.ratingType);

  @override
  Widget build(BuildContext ctx) => Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: ratingType == TYPE_LANDLORD
                  ? Icon(Icons.person_outline)
                  : Icon(Icons.home),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text(
                  "*****",
                  style: TextStyle(fontSize: 40),
                ),
              ),
            )
          ],
        ),
      );
}

/*
Query(
                    options: QueryOptions(
                        document: gql(PropertyQuery.searchForPropertyGQL()),
                        variables: {
                          "price_start": 0,
                          "price_end": 10000,
                          "rooms": 1,
                          "distance": 1000
                        } // ???
                        ),
                    builder: (QueryResult result,
                        {VoidCallback refetch, FetchMore fetchMore}) {
                      if (result.hasException)
                        return Text(result.exception.toString());
                      if (result.isLoading) return Text("Loading");
                      //return Text("Loaded!");
                      List<Object> propertyResults =
                          result.data["searchForProperties"]["data"]
                              ["search_results"];
                      if (propertyResults.length == 0)
                        return Text("No results for given param");
                      return Expanded(
                          child: ListView.separated(
                        itemCount: propertyResults.length,
                        itemBuilder: (BuildContext context, int index) {
                          return PropertyCard(result.data["searchForProperties"]
                              ["data"]["search_results"][index]);
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(
                          color: Colors.white,
                        ),
                      ));
                    },
                  )
                  */

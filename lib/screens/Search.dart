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
    print("Go to -> Add Filters");
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
        SingleChildScrollView(
            child: Container(
          alignment: Alignment.topLeft,
          child: Column(
            children: [NewPropertyCard(), NewPropertyCard()],
          ),
        ))
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
                    children: [
                      Container(
                          color: Colors.red,
                          constraints: BoxConstraints.tightFor(
                            width: 200,
                            height: 100,
                          )),
                      Container(
                          color: Colors.green,
                          constraints: BoxConstraints.tightFor(
                            width: 200,
                            height: 100,
                          )),
                      Container(
                          color: Colors.blue,
                          constraints: BoxConstraints.tightFor(
                            width: 200,
                            height: 100,
                          ))
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Text("Roe Jogan / 10 Photos / 4 Reviews",
                      style: TextStyle(fontSize: 12)),
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: Colors.red,
                        child: Text("Landlord Rating Goes Here"),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: Colors.orange,
                        child: Text("Property Rating Goes Here"),
                      ),
                    )
                  ],
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
              Text("Filter Page!")
            ],
          )));
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

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_fl/components/Button.dart';
import 'package:mobile_fl/constants.dart';
import 'package:mobile_fl/screens/UserAccessBottomNavContainer.dart';

class PropertyInfoScreen extends StatefulWidget {
  @override
  _PropertyInfoScreenState createState() => _PropertyInfoScreenState();
}

class _PropertyInfoScreenState extends State<PropertyInfoScreen> {
  @override
  Widget build(BuildContext ctx) => Column(
        children: [
          AppHeader(
            "Property Info",
            mode: AppHeader.MODE_BACK,
            parentCtx: ctx,
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Container(
              alignment: Alignment.topLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("2227 14th St",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  Text("Troy NY, 12180"),
                  Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: SizedBox(
                        height: 20,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: (() {
                            List<String> tagNames = [
                              "Furnished",
                              "Washer",
                              "Heating",
                              "Heating",
                              "Heating",
                              "Heating",
                              "Heating",
                            ];
                            List<Widget> tags = [];

                            for (int i = 0; i < tagNames.length; ++i) {
                              tags.add(Container(
                                padding: EdgeInsets.fromLTRB(7, 2, 7, 2),
                                child: Text(tagNames[i],
                                    style: TextStyle(
                                        color: Constants.navy(), fontSize: 14)),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    color: Constants.navy(opacity: 0.15)),
                                margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                              ));
                            }

                            return tags;
                          })(),
                        ),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text("Roe Jogan"),
                      ),
                      SizedBox(
                        width: 220,
                        child: Button(
                          onPress: () {
                            Navigator.of(ctx).push(CupertinoPageRoute(
                                builder: (context) => AvailableLeasesScreen()));
                          },
                          text: "3 Leases Available",
                          textColor: Colors.white,
                          backgroundColor: Constants.pink(),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        width: 1, color: Constants.navy(opacity: 0.3)))),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        width: 1, color: Constants.navy(opacity: 0.3)))),
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Photos",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "10",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    )),
                SizedBox(
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: (() {
                      List<Widget> imageHolders = [];

                      for (int i = 0; i < 10; ++i) {
                        imageHolders.add(Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color: Constants.navy(opacity: 0.3))),
                          constraints: BoxConstraints.expand(
                              width: 150 + (Random().nextDouble() * 200)),
                          margin:
                              EdgeInsets.fromLTRB(i == 0 ? 10 : 0, 0, 10, 0),
                        ));
                      }

                      return imageHolders;
                    })(),
                  ),
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        width: 1, color: Constants.navy(opacity: 0.3)))),
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Column(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Ratings",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "10",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Landlord"),
                          Text("*****", style: TextStyle(fontSize: 40))
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Property"),
                          Text("*****", style: TextStyle(fontSize: 40))
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Reviews",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "10",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      );
}

class AvailableLeasesScreen extends StatefulWidget {
  @override
  _AvailableLeasesScreenState createState() => _AvailableLeasesScreenState();
}

class _AvailableLeasesScreenState extends State<AvailableLeasesScreen> {
  @override
  Widget build(BuildContext ctx) => Column(
        children: [
          AppHeader(
            "Available Leases",
            mode: AppHeader.MODE_BACK,
            parentCtx: ctx,
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 1, color: Constants.navy(opacity: 0.3)))),
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Column(
                    children: [
                      Container(
                        child: Text(
                          "3 Leases Available for Property",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        alignment: Alignment.topLeft,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.fromLTRB(5, 10, 0, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("2227 14th St"),
                            Text("Troy NY, 12180")
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: ListView(
                  children: (() =>
                      [for (int i = 0; i < 10; ++i) AvailableLeaseModal()])()),
              alignment: Alignment.topLeft,
            ),
            // child: ListView(
            //     children: (() =>
            //         [for (int i = 0; i < 10; ++i) AvailableLeaseModal()])()),
          )
        ],
      );
}

class AvailableLeaseModal extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) => Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          children: [
            Container(
              child:
                  Text("Room 1", style: TextStyle(fontWeight: FontWeight.bold)),
              alignment: Alignment.topLeft,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text("Start Date"), Text("April 30, 2021")],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text("End Date"), Text("December 30, 2021")],
            ),
            Container(
              alignment: Alignment.topRight,
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: SizedBox(
                width: 200,
                child: Button(
                  text: "Request Lease",
                  textColor: Colors.white,
                  backgroundColor: Constants.pink(),
                ),
              ),
            )
          ],
        ),
      );
}

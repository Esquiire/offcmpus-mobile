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
import 'package:carousel_slider/carousel_slider.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(
          "https://s.hdnux.com/photos/71/12/43/14985455/3/rawImage.jpg"),
    );
  }
}

class PropertyScreen extends StatefulWidget {
  @override
  _PropertyScreenState createState() => _PropertyScreenState();
}

class _PropertyScreenState extends State<PropertyScreen> {
  dynamic box;

  List cardList = [ImageCard(), ImageCard(), ImageCard()];

  @override
  Widget build(BuildContext ctx) {
    final Map propertyInfo = ModalRoute.of(ctx).settings.arguments;
    return AuthWrapper(
      authLevel: AuthLevels.STUDENT,
      ctx: ctx,
      body: Scaffold(
          appBar: AppBar(
            title: Text(propertyInfo["property"]["address_line"]),
          ),
          body: Container(
              margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(children: [
                CarouselSlider(
                  options: CarouselOptions(height: 200.0),
                  items: cardList.map((card) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            child: card);
                      },
                    );
                  }).toList(),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text("Owned by: " +
                        propertyInfo["landlord_first_name"] +
                        " " +
                        propertyInfo["landlord_last_name"]),
                    Spacer(),
                    Text("Landlord Rating: " +
                        propertyInfo["landlord_rating_avg"].toString()),
                    Spacer(),
                    Text("Property Rating: " +
                        propertyInfo["property_rating_avg"].toString())
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    propertyInfo["lease_count"] == 1
                        ? Text(propertyInfo["lease_count"].toString() +
                            " available lease")
                        : Text(propertyInfo["lease_count"].toString() +
                            " available leases"),
                    Spacer(),
                    propertyInfo["property"]["details"]["furnished"]
                        ? Text(
                            "Furnished",
                            style: TextStyle(color: Colors.green),
                          )
                        : Text("Unfurnished",
                            style: TextStyle(color: Colors.red)),
                    Spacer(),
                    Text(propertyInfo["property"]["details"]["sq_ft"]
                            .toString() +
                        "sq feet")
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(propertyInfo["property"]["details"]["rooms"]
                            .toString() +
                        " bedrooms"),
                    Spacer(),
                    Text(propertyInfo["property"]["details"]["bathrooms"]
                            .toString() +
                        " bathrooms")
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    propertyInfo["property"]["details"]["has_washer"]
                        ? Text(
                            "Washer",
                            style: TextStyle(color: Colors.green),
                          )
                        : Text(
                            "No Washer",
                            style: TextStyle(color: Colors.red),
                          ),
                    Spacer(),
                    propertyInfo["property"]["details"]["has_heater"]
                        ? Text(
                            "Heat",
                            style: TextStyle(color: Colors.green),
                          )
                        : Text(
                            "No Heat",
                            style: TextStyle(color: Colors.red),
                          ),
                    Spacer(),
                    propertyInfo["property"]["details"]["has_ac"]
                        ? Text(
                            "AC",
                            style: TextStyle(color: Colors.green),
                          )
                        : Text(
                            "No AC",
                            style: TextStyle(color: Colors.red),
                          ),
                  ],
                ),
                SizedBox(height: 10),
                Text("Description: "),
                Text(
                  propertyInfo["property"]["details"]["description"],
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ], crossAxisAlignment: CrossAxisAlignment.start))),
    );
  }
}

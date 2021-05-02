import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:mobile_fl/screens/Property.dart';

class PropertyCard extends StatefulWidget {
  final Map propertyInformation;
  PropertyCard(this.propertyInformation);
  @override
  _PropertyCardState createState() => _PropertyCardState();
}

/**
 * @desc Our feed ListBuilder consists of PropertyCard widgets.
 * Each PropertyCard has an image of the property, as well as price
 * and a few key amenities.  Users can 'like' a property and save it for 
 * later by tapping the heart button, which is state-managed.
 */

class _PropertyCardState extends State<PropertyCard> {
  
  //State management for heart icon
  int fabIconNumber = 0;
  Icon notLiked = Icon(
    Icons.favorite_border,
    color: Colors.red,
  );
  Icon liked = Icon(
    Icons.favorite,
    color: Colors.red,
  );
  Icon fab = Icon(
    Icons.favorite_border,
    color: Colors.red,
  );

  @override
  Widget build(BuildContext ctx) {
    // we can pull theme options from upper widgets,
    // meaning future updates to theming is seamless.
    return Center(
      child: Card(
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            Navigator.push(
                ctx,
                MaterialPageRoute(
                  builder: (BuildContext context) => PropertyScreen(),
                  settings: RouteSettings(
                    arguments: widget.propertyInformation,
                  ),
                ));
          },
          child: Container(
            child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(children: <Widget>[
                  Image.network(
                      "https://s.hdnux.com/photos/71/12/43/14985455/3/rawImage.jpg"),
                  Row(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(widget.propertyInformation["property"]
                              ["address_line"]),
                          Text(
                              widget.propertyInformation[
                                      "landlord_first_name"] +
                                  " " +
                                  widget.propertyInformation[
                                      "landlord_last_name"],
                              style: TextStyle(fontStyle: FontStyle.italic))
                        ],
                        crossAxisAlignment: CrossAxisAlignment.center,
                      ),
                      Spacer(),
                      new ButtonBar(
                        children: <Widget>[
                          new IconButton(
                            icon: Icon(Icons.content_copy),
                            //onPressed: REFRESH,
                          ),
                          new IconButton(
                              icon: fab,
                              onPressed: () => setState(() {
                                    if (fabIconNumber == 0) {
                                      fab = liked;
                                      fabIconNumber = 1;
                                    } else {
                                      fab = notLiked;
                                      fabIconNumber = 0;
                                    }
                                  })),
                          new IconButton(
                            icon: Icon(Icons.arrow_forward_rounded),
                            //onPressed: COPY,
                          ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                          "\$" +
                              widget.propertyInformation["price_range"][0]
                                  .toString(),
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w500,
                              fontSize: 20)),
                      Spacer(),
                      Column(
                        children: [
                          Text(widget.propertyInformation["property"]["details"]
                              ["description"])
                        ],
                      ),
                      Spacer(),
                      Column(
                        children: [],
                      )
                    ],
                  )
                ])),
          ),
        ),
      ),
    );
  }
}

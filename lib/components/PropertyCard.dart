import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PropertyCard extends StatefulWidget {
  final String address;
  final String cardContent;
  PropertyCard(this.address, this.cardContent);
  @override
  _PropertyCardState createState() => _PropertyCardState();
}

class _PropertyCardState extends State<PropertyCard> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {},
          child: Container(
            child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(widget.address),
                      Spacer(),
                      new ButtonBar(
                        children: <Widget>[
                          new IconButton(
                            icon: Icon(Icons.arrow_forward_rounded),
                            //onPressed: REFRESH,
                          ),
                          new IconButton(
                            icon: Icon(
                              Icons.favorite_border,
                              color: Colors.redAccent,
                            ),
                            //onPressed: BOOKMARK,
                          ),
                          new IconButton(
                            icon: Icon(Icons.content_copy),
                            //onPressed: COPY,
                          ),
                        ],
                      )
                    ],
                  ),
                  Text(widget.cardContent)
                ])),
          ),
        ),
      ),
    );
  }
}

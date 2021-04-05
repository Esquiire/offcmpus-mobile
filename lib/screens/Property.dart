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

class PropertyScreen extends StatefulWidget {
  @override
  _PropertyScreenState createState() => _PropertyScreenState();
}

class _PropertyScreenState extends State<PropertyScreen> {
  dynamic box;

  @override
  Widget build(BuildContext ctx) {
    final Map propertyInfo = ModalRoute.of(context).settings.arguments;
    return AuthWrapper(
      authLevel: AuthLevels.STUDENT,
      ctx: ctx,
      body: Scaffold(
        appBar: AppBar(
          title: Text(propertyInfo["property"]["address_line"]),
        ),
      ),
    );
  }
}

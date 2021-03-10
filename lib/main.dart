import 'package:flutter/material.dart';
// import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:mobile_fl/screens/Register.dart';
// import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

String backendPath(String path) => "http://10.0.2.2:9010$path";

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue),
        initialRoute: '/',
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/': (context) => LandingScreen(),
          '/register': (context) => RegisterScreen(),
          // When navigating to the "/second" route, build the SecondScreen widget.
          '/search': (context) => SearchScreen(),
        });
  }
}

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  void goToRegistration(BuildContext ctx) {
    Navigator.pushNamed(ctx, '/register');
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Landing"),
      ),
      body: TextButton(
        onPressed: () => goToRegistration(ctx),
        child: Text("Register"),
      ),
    );
  }
}

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
      ),
      body: Text("Search Page"),
    );
  }
}

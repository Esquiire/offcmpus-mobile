import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mobile_fl/API/AuthAPI.dart';
import 'package:mobile_fl/API/GQLConfig.dart';
import 'package:mobile_fl/components/AuthWrapper.dart';
import 'package:mobile_fl/screens/Login.dart';
import 'package:mobile_fl/screens/Register.dart';
import 'package:hive/hive.dart';

// Setup GraphQL Client
GQLConfig gqlConfiguration = GQLConfig();
void main() async {
  await initHiveForFlutter();

  // register the adapters
  Hive.registerAdapter(StudentStateAdapter());

  // ? TESTING : Does Hive have persistent data storage ??
  // * ANSWER : Yes, the data does persist after application closes.

  // TODO before the app launches (here), see if the student`
  // object has a connect.Sid. If so, try to fetch the
  // user data.
  // If the session is still active, then log them in automatically.
  // Otherwise, they need to log in again.

  runApp(GraphQLProvider(
      client: gqlConfiguration.client,
      child: CacheProvider(child: AppEntry())));
}

class AppEntry extends StatelessWidget {
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
          '/': (context) => AppEntryScreen(),
          '/landing': (context) => LandingScreen(),
          '/login': (context) => LoginScreen(),
          '/register': (context) => RegisterScreen(),
          '/search': (context) => SearchScreen(),
        });
  }
}

class AppEntryScreen extends StatelessWidget {
  bool processing = false;
  @override
  Widget build(BuildContext ctx) {
    // we only want to call this once
    if (!this.processing) checkAuth(ctx);
    this.processing = true;
    return Container();
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

  void goToLogin(BuildContext ctx) {
    Navigator.pushNamed(ctx, '/login');
  }

  @override
  Widget build(BuildContext ctx) {
    return AuthWrapper(
      ctx: ctx,
      authLevel: AuthLevels.UNAUTH,
      body: Scaffold(
        appBar: AppBar(
          title: Text("Landing"),
        ),
        body: Column(
          children: [
            TextButton(
              onPressed: () => goToRegistration(ctx),
              child: Text("Register"),
            ),
            TextButton(
              onPressed: () => goToLogin(ctx),
              child: Text("Login"),
            )
          ],
        ),
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
    return AuthWrapper(
      authLevel: AuthLevels.STUDENT,
      ctx: ctx,
      body: Scaffold(
        appBar: AppBar(
          title: Text("Search"),
        ),
        body: Text("Search Page"),
      ),
    );
  }
}

/**
 * Check and verify that the student is authenticated.
 * If they are authenticated, take them to the authenticated
 * screen.
 * Otherwise, take them to the landing screen.
 */
void checkAuth(BuildContext ctx) async {
  var box = await Hive.openBox('appState');
  StudentState student = box.get('student');

  if (student == null || student.connectSid == null)
    Navigator.pushNamedAndRemoveUntil(ctx, '/landing', (r) => false);

  return StudentState.fetchUserData().then((bool success) {
    if (success)
      Navigator.pushNamedAndRemoveUntil(ctx, '/search', (r) => false);
    else
      Navigator.pushNamedAndRemoveUntil(ctx, '/landing', (r) => false);
  });
}

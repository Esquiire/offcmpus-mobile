import 'package:flutter/cupertino.dart';
import 'package:mobile_fl/API/AuthAPI.dart';

// Constants used to identify levels of
// authentication.
class AuthLevels {
  static const int STUDENT = 4;
  static const int UNAUTH = 6;
}

class AuthWrapper extends StatelessWidget {
  final int authLevel;
  final Widget body;
  final BuildContext ctx;

  AuthWrapper({this.authLevel, this.body, this.ctx}) {
    checkAuth();
  }

  /**
   * @desc Determine whether the screen is allowed to be
   * seen by the user based on the defined authLevel.
   */
  void checkAuth() async {
    // check if the user is authenticated
    StudentState.fetchUserData().then((bool authenticated) {
      // If the user is authenticated ...
      if (authenticated) {
        // if the user is authenticated and the page requires
        // authentication, then do nothing.
        if (authLevel == AuthLevels.STUDENT)
          return;

        // else if the user is unauthenticated and the view is only for unauthenticated
        // users, take them to the default authenticated route, /search.
        else if (authLevel == AuthLevels.UNAUTH)
          Navigator.pushNamedAndRemoveUntil(ctx, '/userAccess', (r) => false);
      }

      // If the user is unauthenticated ...
      else {
        // if the user is unauthenticated and the view is only for unauthenticated
        // users, then do nothing.
        if (authLevel == AuthLevels.UNAUTH)
          return;

        // otherwise, if the user is unauthenticated and the page requires
        // authentication, then take them to the login screen.
        else if (authLevel == AuthLevels.STUDENT)
          Navigator.pushNamedAndRemoveUntil(ctx, '/landing', (r) => false);
      }
    });
  }

  @override
  Widget build(BuildContext ctx) => body;
}

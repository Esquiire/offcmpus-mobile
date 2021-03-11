import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_fl/API/AuthAPI.dart';
import 'package:mobile_fl/components/Button.dart';
import 'package:mobile_fl/components/Input.dart';
import 'package:mobile_fl/constants.dart';
import 'package:hive/hive.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Map<String, String> form = Map<String, String>();
  String errorMsg = null;

  static final List<String> fields = ["email", "password"];
  void setFormValue(String key, String value) {
    // only set the value for fields specified
    // in the array.
    if (!fields.contains(key)) return;

    setState(() {
      form[key] = value;
    });
  }

  bool formValid() {
    for (String key in fields) {
      if (!form.containsKey(key)) return false;
      if (form[key].length == 0) return false;
    }

    // TODO add email validation

    return true;
  }

  void logStudentIn(BuildContext ctx) {
    // Todo log the student in ...
    AuthAPI.login(form["email"], form["password"]).then((response) {
      AuthAPI.processAuthResponse(response).then((String connectSid) async {
        if (connectSid != null) {
          var student = new StudentState();
          student.connectSid = connectSid;

          // Store the connectsid information in the
          // hive box
          var box = await Hive.openBox("appState");
          await box.put('student', student);

          // fetch the user's information
          StudentState.fetchUserData().then((bool success) async {
            if (success) {
              debugPrint("Successfully stored user information!");
              processAuthAndRoute(ctx);
            } else
              debugPrint("Error fetching user data");
          });
        } else {
          setState(() {
            this.errorMsg = "Login failed.";
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
        appBar: AppBar(title: Text("Login")),
        body: Container(
            margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Column(children: [
              Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Input(
                        label: "Email",
                        onChange: (String val) {
                          setFormValue("email", val);
                        },
                      ),
                      Input(
                        label: "Password",
                        onChange: (String val) {
                          setFormValue("password", val);
                        },
                      )
                    ],
                  )),
              Container(
                // constraints: BoxConstraints.expand(height: 80),
                child: Column(
                  children: [
                    errorMsg == null
                        ? Container()
                        : Container(
                            child: Text(errorMsg,
                                style: TextStyle(color: Colors.red[700])),
                          ),
                    Button(
                      text: "Continue",
                      textColor: Colors.white,
                      backgroundColor:
                          formValid() ? Constants.pink() : Constants.grey(),
                      onPress: formValid() ? () => logStudentIn(ctx) : () {},
                    )
                  ],
                ),
              )
            ])));
  }
}

/**
 * @desc See whether or not the student is authorized / logged in.
 * If so, take them to the application home page.
 * 
 * @prerequisite The server must have been pinged previously to
 * ensure the user is authenticated.
 */
void processAuthAndRoute(BuildContext ctx) async {
  var box = await Hive.openBox("appState");
  StudentState student = box.get("student");

  // TODO if there is a session
  if (student.connectSid == null) return;

  // take to the home page!
  Navigator.pushNamed(ctx, '/search');
}

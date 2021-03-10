import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_fl/API/AuthAPI.dart';
import 'package:mobile_fl/components/Button.dart';
import 'package:mobile_fl/components/Input.dart';
import 'package:mobile_fl/constants.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  Map<String, String> map = Map<String, String>();

  static final List<String> fields = [
    "first_name",
    "last_name",
    "school_email",
    "school_email_confirm"
  ];

  void setFormValue(String key, String value) {
    // only set the value for fields specified
    // in the array.
    if (!fields.contains(key)) return;

    setState(() {
      map[key] = value;
    });
  }

  void handleSubmit(BuildContext ctx) {
    Navigator.push(
        ctx,
        MaterialPageRoute(
            builder: (ctx) => RegisterPart2(),
            settings: RouteSettings(arguments: map)));
  }

  /**
   * @desc Determine whether or not the
   * form is valid.
   * The map of field values must contain
   * all the specified fields
   */
  bool formValid() {
    int fieldCount = 0;

    for (String key in map.keys) {
      if (fields.contains(key)) ++fieldCount;

      // check to make sure the field is not empty
      if (map[key].length == 0) return false;

      // TODO check to make sure the email fields are
      // actually emails
    }

    if (map["school_email"] != map["school_email_confirm"]) return false;

    // all fields are not set
    if (fieldCount < fields.length) return false;
    return true;
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registration"),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          children: [
            Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Input(
                      label: "First Name",
                      onChange: (String val) {
                        setFormValue("first_name", val);
                      },
                    ),
                    Input(
                      label: "Last Name",
                      onChange: (String val) {
                        setFormValue("last_name", val);
                      },
                    ),
                    Input(
                      label: "School Email",
                      onChange: (String val) {
                        setFormValue("school_email", val);
                      },
                    ),
                    Input(
                      label: "Confirm School Email",
                      onChange: (String val) {
                        setFormValue("school_email_confirm", val);
                      },
                    )
                  ],
                )),
            Container(
              // constraints: BoxConstraints.expand(height: 80),
              child: Button(
                text: "Continue",
                textColor: Colors.white,
                backgroundColor:
                    formValid() ? Constants.pink() : Constants.grey(),
                onPress: formValid() ? () => handleSubmit(ctx) : () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RegisterPart2 extends StatefulWidget {
  @override
  _RegisterPart2State createState() => _RegisterPart2State();
}

class _RegisterPart2State extends State<RegisterPart2> {
  void returnToRegistrationStart(BuildContext ctx) {
    Navigator.pushNamed(ctx, '/register');
  }

  Map<String, String> form = null;

  static final List<String> fields = [
    "password",
    "password_confirm",
    "preferred_email_set",
    "preferred_email",
    "preferred_email_confirm"
  ];

  void setFormValue(String key, String value) {
    // only set the value for fields specified
    // in the array.
    if (!fields.contains(key)) return;

    setState(() {
      form[key] = value;
    });
  }

  bool formValid() {
    int fieldCount = form.keys.length;

    // preferred email, confirm preferred email and preferred email set are all optional
    // fields.
    if (fieldCount <
        _RegisterPart2State.fields.length +
            _RegisterScreenState.fields.length -
            3) return false;

    for (String key in form.keys) {
      if (!_RegisterPart2State.fields.contains(key) &&
          !_RegisterScreenState.fields.contains(key)) return false;

      // skip the prefererd email fields
      if (key == "preferred_email_set") continue;
      if (key == "preferred_email") continue;
      if (key == "preferred_email_confirm") continue;

      if (form[key].length == 0) return false;
    }

    if (form["password"] != form["password_confirm"]) return false;
    if (form["preferred_email_set"] == "yes" &&
        form["preferred_email"] != form["preferred_email_confirm"])
      return false;

    return true;
  }

  void validate(BuildContext ctx) {
    if (form == null) {
      // invalid
      returnToRegistrationStart(ctx);
    }

    int fieldCount = form.keys.length;
    if (fieldCount != _RegisterScreenState.fields.length)
      returnToRegistrationStart(ctx);

    for (String key in form.keys) {
      if (!_RegisterScreenState.fields.contains(key))
        returnToRegistrationStart(ctx);
    }
  }

  void updateCheckbox(bool newValue) {
    setState(() {
      form["preferred_email_set"] = newValue ? "yes" : "no";
    });
  }

  void handleRegistrationCompletion(BuildContext ctx) {
    // TODO submit form !
    AuthAPI.login("test@rpi.edu", "password").then((response) {
      debugPrint(response.toString());
      // process the auth cookie that is stored in the header
      AuthAPI.processAuthResponse(response).then((bool success) {
        if (success)
          debugPrint("Successfully stored the connect.sid cookie!");
        else
          debugPrint("Could not find the connect.sid cookie...");
      });
    });
  }

  bool preferredEmailSet() =>
      form != null &&
      form.containsKey("preferred_email_set") &&
      form["preferred_email_set"] == "yes";

  @override
  Widget build(BuildContext ctx) {
    // get the current form data
    if (this.form == null) {
      this.form = ModalRoute.of(ctx).settings.arguments;
      // validate the form to make sure it has the expected data
      validate(ctx);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Registration"),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Input(
                    label: "Password",
                    password: true,
                    onChange: (String val) {
                      setFormValue("password", val);
                    },
                  ),
                  Input(
                    label: "Confirm Password",
                    password: true,
                    onChange: (String val) {
                      setFormValue("password_confirm", val);
                    },
                  ),
                  Row(
                    children: [
                      Checkbox(
                          value: preferredEmailSet(),
                          onChanged: updateCheckbox),
                      Text("Use a preferred email address to log in")
                    ],
                  ),
                  preferredEmailSet()
                      ? Column(
                          children: [
                            Input(
                              label: "Preferred Email",
                              onChange: (String val) {
                                setFormValue("preferred_email", val);
                              },
                            ),
                            Input(
                              label: "Confirm Preferred Email",
                              onChange: (String val) {
                                setFormValue("preferred_email_confirm", val);
                              },
                            ),
                          ],
                        )
                      : Container()
                ],
              ),
            ),
            Container(
              // constraints: BoxConstraints.expand(height: 80),
              child: Button(
                text: "Complete",
                textColor: Colors.white,
                backgroundColor:
                    formValid() ? Constants.pink() : Constants.grey(),
                onPress: formValid()
                    ? () => handleRegistrationCompletion(ctx)
                    : () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}

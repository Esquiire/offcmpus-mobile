import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void emptyHandeler(String _) {}

/**
 * Custom Input:
 * Input field with validation.
 * Further, allows for custom form creation.
*/
class Input extends StatefulWidget {
  const Input(
      {this.label,
      this.onSubmit = emptyHandeler,
      this.onChange = emptyHandeler,
      this.enableSuggestions = false,
      this.autoCorrect = false,
      this.password = false});

  // label: The label for the input field
  final bool enableSuggestions;
  final bool autoCorrect;
  final String label;
  final bool password;
  final Function(String) onSubmit;
  final Function(String) onChange;

  @override
  _InputState createState() => _InputState();
}

class _InputState extends State<Input> {
  @override
  Widget build(BuildContext ctx) {
    return Container(
      child: TextField(
        obscureText: widget.password,
        autocorrect: widget.autoCorrect,
        enableSuggestions: widget.enableSuggestions,
        onSubmitted: (String val) {
          widget.onSubmit(val);
        },
        onChanged: (String val) {
          widget.onChange(val);
        },
        decoration: InputDecoration(
            labelText: widget.label, border: const OutlineInputBorder()),
      ),
      margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
    );
  }
}

// class Validators {
//   static bool isEmail(String val) => new RegExp(
//           '^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))')
//       .hasMatch(val);
// }

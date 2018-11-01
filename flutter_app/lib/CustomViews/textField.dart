import 'package:flutter/material.dart';

Widget textField(TextEditingController controller, bool secureText,
    String hintText, String labelName, Icon icon) {
  return Padding(
    padding: EdgeInsets.all(16.0),
    child: Material(
        child: new TextFormField(
          decoration: InputDecoration(
            icon: icon,
            hintText: hintText,
            labelText: labelName,
          ),
          obscureText: secureText,
          controller: controller,
          // The validator receives the text the user has typed in
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter some text';
            }
          },
        )),
  );
}
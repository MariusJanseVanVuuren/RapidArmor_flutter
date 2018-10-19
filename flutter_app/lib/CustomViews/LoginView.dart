import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoginContainer();
  }

  Widget LoginContainer() {
    var rapidArmorLogo = new AssetImage("Assets/RapidArmorLogo.jpg");
    return Container(
      color: Colors.white,
      child: ListView(
        children: <Widget>[
          Image(image: rapidArmorLogo, width: 200.0, height: 150.0),
          MyCustomForm()
        ],
      ),
    );
  }
}

// Define a Custom Form Widget
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Define a corresponding State class. This class will hold the data related to
// the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that will uniquely identify the Form widget and allow
  // us to validate the form
  //
  // Note: This is a `GlobalKey<FormState>`, not a GlobalKey<MyCustomFormState>!
  final _formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey we created above
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            textField(userNameController, false, "Enter your Email", "Email", Icon(Icons.person)),
            textField(passwordController, true, "Enter your password", "Password", Icon(Icons.lock))
          ],
        ));
  }

  Widget textField(TextEditingController controller, bool secureText, String hintText, String labelName, Icon icon) {
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
}

import 'package:flutter/material.dart';
import 'package:flutter_app/CustomViews/RapidArmorHomeListView.dart';
import 'package:flutter_app/Networking/LoginRequest.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/CustomViews/textField.dart';

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
  bool isLoading = false;

  // Create a global key that will uniquely identify the Form widget and allow
  // us to validate the form
  //
  // Note: This is a `GlobalKey<FormState>`, not a GlobalKey<MyCustomFormState>!
  final _formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();

  final passwordController = TextEditingController();

  var loginButton;

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey we created above

    loginButton = RaisedButton(
        onPressed: performLoginAction,
        color: Colors.red,
        padding: const EdgeInsets.all(8.0),
        child: raisedButtonContent());


    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            textField(userNameController, false, "Enter your Email", "Email",
                Icon(Icons.person)),
            textField(passwordController, true, "Enter your password",
                "Password", Icon(Icons.lock)),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.all(50.0),
                    child: loginButton)
              ],
            )
          ],
        ));
  }

  Widget raisedButtonContent() {
    if (isLoading == true) {
      return new Center(child: new CircularProgressIndicator());
    } else {
      return new Center(child: Text("Login"));
    }
  }

  void performLoginAction() async {
    updateState(true);
    http.Response response =
    await loginRequest(userNameController.text, passwordController.text);
    if (response.statusCode == 200) {
      Navigator.pop(
          context
      );
    } else {
      updateState(false);
      _showDialog("Login Failed", "Please check you username and passord");
    }
  }

  void updateState(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }

  void _showDialog(String title, String subtitle) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(title),
          content: new Text(subtitle),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}


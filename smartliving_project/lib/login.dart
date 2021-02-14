import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartliving_project/authenication.dart';

// Import pages
import 'register.dart';

// Login Page
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App Bar
      appBar: AppBar(
        title: Text(
          'Login Account',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      // End of App Bar
      // Body Section
      body: Center(
        child: ListView(
          padding: const EdgeInsets.symmetric(
            vertical: 50.0,
            horizontal: 15.0,
          ),
          shrinkWrap: true,
          children: <Widget>[
            // Heading
            Text(
              'Login to Smart Living',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            // End of Heading
            SizedBox(
              height: 30,
            ),
            // Display Login Form
            LoginForm(),
            SizedBox(
              height: 30,
            ),
            // Register Link
            Text(
              'Don\'t have an account yet?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            // Register Button
            FlatButton(
              padding: const EdgeInsets.all(0.0),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterPage(),
                  ),
                );
              },
              child: Text(
                'Register now!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.indigo,
                  fontSize: 16,
                ),
              ),
            ),
            // End of Register Button
            // End of Register Link
          ],
        ),
      ),
      // End of Body Section
    );
  }
}
// End of Login Page

// Login Form
class LoginForm extends StatefulWidget {
  LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String formMessage = '';

  final _formKey = GlobalKey<FormState>();
  var _thisEmail = GlobalKey<FormFieldState>();
  var _thisPassword = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Email Field
          TextFormField(
            key: _thisEmail,
            decoration: InputDecoration(
              // Label Text
              labelText: 'Email',
              // Prefix Icon
              prefixIcon: Icon(Icons.mail_rounded),
            ),
            // Validate Input Field
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter your email!';
              }
              return null;
            },
          ),
          // End of Email Field
          SizedBox(
            height: 30,
          ),
          // Password Field
          TextFormField(
            key: _thisPassword,
            decoration: InputDecoration(
              // Label Text
              labelText: 'Password',
              // Prefix Icon
              prefixIcon: Icon(Icons.lock),
            ),
            // Mask Input Field
            obscureText: true,
            // Validate Input Field
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter your password!';
              }
              return null;
            },
          ),
          // End of Password Field
          // Form Message
          Padding(
            padding: EdgeInsets.all(25.0),
            child: Text(
              formMessage,
              style: TextStyle(color: Colors.red, fontSize: 13),
              textAlign: TextAlign.center,
            ),
          ),
          // End of Form Message
          // Login Button
          RaisedButton(
            onPressed: () async {
              // Execute if all the entered values are valid
              if (_formKey.currentState.validate()) {
                // Attempt login account
                dynamic result =
                    context.read<AuthenicationService>().loginAccount(
                          email: _thisEmail.currentState.value,
                          password: _thisPassword.currentState.value,
                        );

                // Check if login successful
                if (await result != null) {
                  Navigator.pop(context);
                } else {
                  setState(
                      () => formMessage = 'Email or password is incorrect!');
                }
              }
            },
            highlightElevation: 5.0,
            elevation: 5.0,
            child: Text(
              'Login',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          // End of Login Button
        ],
      ),
    );
  }
}
// End of Login Form

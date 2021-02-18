import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartliving_project/authenication.dart';
import 'login.dart';

// Register Page
class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App Bar
      appBar: AppBar(
        title: Text(
          'Register Account',
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
              'Welcome to Smart Living',
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
            // Register Form
            RegisterForm(),
            // End of Register Form
            SizedBox(
              height: 30,
            ),
            // Login Link
            Text(
              'Already have an account?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            // Login Button
            FlatButton(
              padding: const EdgeInsets.all(0.0),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
              child: Text(
                'Login Now',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.indigo,
                  fontSize: 16,
                ),
              ),
            ),
            // End of Login Button
            // End of Login Link
          ],
        ),
      ),
      // End of Body Section
    );
  }
}
// End of Register Page

// Register Form
class RegisterForm extends StatefulWidget {
  RegisterForm({Key key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  String formMessage = '';

  final _formKey = GlobalKey<FormState>();
  var _thisEmail = GlobalKey<FormFieldState>();
  var _thisUsername = GlobalKey<FormFieldState>();
  var _thisPhoneNumber = GlobalKey<FormFieldState>();
  var _thisPassword = GlobalKey<FormFieldState>();

  // Register Success Dialog
  Future registerSuccessDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // Display title
          title: Text('Register'),
          // Display message
          content: Text(
              'You have registered your account, you will be logged in automatically.'),
          // Actions
          actions: [
            // Ok Button
            FlatButton(
              onPressed: () {
                // Close the alert dialog
                Navigator.pop(context);
                // Direct to main page
                Navigator.pop(context);
              },
              child: Text(
                'Ok',
                style: TextStyle(color: Colors.indigo),
              ),
            ),
            // End of Ok button
          ],
        );
      },
    );
  }
  // End of Register Success Dialog

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
              } else if (!RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(value)) {
                return 'Please enter a valid email!';
              }
              return null;
            },
          ),
          // End of Email Field
          SizedBox(
            height: 30,
          ),
          // Username Field
          TextFormField(
            key: _thisUsername,
            decoration: InputDecoration(
              // Label Text
              labelText: 'Username',
              // Prefix Icon
              prefixIcon: Icon(Icons.person),
            ),
            // Validate Input Field
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter your username!';
              } else if (value.length <= 3) {
                return 'Username must be more than 3 characters!';
              } else if (value.length >= 18) {
                return 'Username must be less than 18 characters!';
              }
              return null;
            },
          ),
          // End of Username Field
          SizedBox(
            height: 30,
          ),
          // Phone Number Field
          TextFormField(
            key: _thisPhoneNumber,
            decoration: InputDecoration(
              // Label Text
              labelText: 'Phone Number',
              // Prefix Icon
              prefixIcon: Icon(Icons.phone_android),
            ),
            // Set keyboard to numbers only
            keyboardType: TextInputType.number,
            // Validate Input Field
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter your phone number!';
              } else if (value.length != 8) {
                return 'Please enter a valid phone number!';
              }
              return null;
            },
          ),
          // End of Phone Number Field
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
              } else if (value.length <= 5) {
                return 'Password must be more than 5 characters!';
              }
              return null;
            },
          ),
          // End of Password Field
          SizedBox(
            height: 30,
          ),
          // Confirm Password Field
          TextFormField(
            decoration: InputDecoration(
              // Label Text
              labelText: 'Confirm Password',
              // Prefix Icon
              prefixIcon: Icon(Icons.lock),
            ),
            // Mask Input Field
            obscureText: true,
            // Validate Input Field
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter your confirm password!';
              } else if (value != _thisPassword.currentState.value) {
                return 'Confirm Password does not match your chosen password!';
              }
              return null;
            },
          ),
          // End of Confirm Password Field
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
          // Register Button
          RaisedButton(
            onPressed: () async {
              // Execute if all the entered values are valid
              if (_formKey.currentState.validate()) {
                // Attempt to create user account
                Future<String> result =
                    context.read<AuthenicationService>().registerAccount(
                          email: _thisEmail.currentState.value,
                          username: _thisUsername.currentState.value,
                          phoneNumber:
                              int.parse(_thisPhoneNumber.currentState.value),
                          password: _thisPassword.currentState.value,
                        );

                // Check if register is successful
                if (await result == null) {
                  // Display popup
                  registerSuccessDialog(context);
                } else {
                  // Display error message
                  result.then((value) {
                    setState(() => formMessage = value);
                  });
                }
              }
            },
            highlightElevation: 5.0,
            elevation: 5.0,
            child: Text(
              'Register Account',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          // End of Register Button
        ],
      ),
    );
  }
}
// End of Register Form

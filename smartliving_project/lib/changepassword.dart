import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartliving_project/authenication.dart';

// Change Password Page
class ChangePasswordPage extends StatelessWidget {
  ChangePasswordPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App Bar
      appBar: AppBar(
        title: Text(
          'Change Password',
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
              'Change Password',
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
            ChangePasswordForm(),
          ],
        ),
      ),
      // End of Body Section
    );
  }
}
// End of Change Password Page

// Change Password Form
class ChangePasswordForm extends StatefulWidget {
  ChangePasswordForm({Key key}) : super(key: key);

  @override
  _ChangePasswordFormState createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  String formMessage = '';

  final _formKey = GlobalKey<FormState>();
  var _thisCurrentPassword = GlobalKey<FormFieldState>();
  var _thisNewPassword = GlobalKey<FormFieldState>();
  var _thisNewConfirmPassword = GlobalKey<FormFieldState>();

  _ChangePasswordFormState();

  // Change Password Success Dialog
  Future changePWSuccessDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // Display title
          title: Text('Change Password'),
          // Display message
          content: Text('You have successfully changed your password.'),
          // Actions
          actions: [
            // Ok Button
            FlatButton(
              onPressed: () {
                // Close the alert dialog
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

  // End of Change Password Success Dialog
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Current Password Field
          TextFormField(
            key: _thisCurrentPassword,
            decoration: InputDecoration(
              // Label Text
              labelText: 'Password',
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
          // End of Current Password Field
          SizedBox(
            height: 30,
          ),
          // New Password Field
          TextFormField(
            key: _thisNewPassword,
            decoration: InputDecoration(
              // Label Text
              labelText: 'New Password',
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
          // End of New Password Field
          SizedBox(
            height: 30,
          ),
          // New Confirm Password Field
          TextFormField(
            key: _thisNewConfirmPassword,
            decoration: InputDecoration(
              // Label Text
              labelText: 'Confirm New Password',
            ),
            // Mask Input Field
            obscureText: true,
            // Validate Input Field
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter your confirm password!';
              } else if (value != _thisNewPassword.currentState.value) {
                return 'Confirm Password does not match your chosen password!';
              }
              return null;
            },
          ),
          // End of New Confirm Password Field
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
          // Save Button
          RaisedButton(
            onPressed: () async {
              // Execute if all the entered values are valid
              if (_formKey.currentState.validate()) {
                // Validate password
                Future<bool> result = context
                    .read<AuthenicationService>()
                    .validatePassword(
                        firebaseUser: firebaseUser,
                        currentPassword:
                            _thisCurrentPassword.currentState.value);
                // If password correct
                if (await result != null) {
                  // Update new password
                  context.read<AuthenicationService>().updatePassword(
                      firebaseUser: firebaseUser,
                      newPassword: _thisNewPassword.currentState.value);
                  // Display popup and refresh the page
                  _formKey.currentState.reset();
                  changePWSuccessDialog(context);
                } else {
                  setState(
                      () => formMessage = 'Current password is incorrect!');
                }
              }
            },
            highlightElevation: 5.0,
            elevation: 5.0,
            child: Text(
              'Save',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          // End of Save Button
        ],
      ),
    );
  }
}
// End of Change Password Form

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartliving_project/database.dart';
import 'package:provider/provider.dart';

// Edit Profile Page
class EditProfilePage extends StatelessWidget {
  final String email;
  final String username;
  final String phoneNumber;

  EditProfilePage(this.email, this.username, this.phoneNumber, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App Bar
      appBar: AppBar(
        title: Text(
          'Edit Profile',
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
              'Edit Profile',
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
            EditProfileForm(email, username, phoneNumber),
          ],
        ),
      ),
      // End of Body Section
    );
  }
}
// End of Edit Profile Page

// Edit Profile Form
class EditProfileForm extends StatefulWidget {
  final String email;
  final String username;
  final String phoneNumber;

  EditProfileForm(this.email, this.username, this.phoneNumber, {Key key})
      : super(key: key);

  @override
  _EditProfileFormState createState() =>
      _EditProfileFormState(email, username, phoneNumber);
}

class _EditProfileFormState extends State<EditProfileForm> {
  String email;
  String username;
  String phoneNumber;
  String formMessage = '';

  final _formKey = GlobalKey<FormState>();
  var _thisUsername = GlobalKey<FormFieldState>();
  var _thisPhoneNumber = GlobalKey<FormFieldState>();

  _EditProfileFormState(this.email, this.username, this.phoneNumber);

  // Edit Profile Success Dialog
  Future editProfileSuccessDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // Display title
          title: Text('Edit Profile'),
          // Display message
          content: Text('Profile successfully updated.'),
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
  // End of Edit Profile Success Dialog

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Email Field
          TextFormField(
            decoration: InputDecoration(
              // Label Text
              labelText: 'Email',
              // Prefix Icon
            ),
            // Disable form field
            enabled: false,
            // Declare Initial Value
            initialValue: email,
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
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 5.0),
            child: Text(
              '* Email address is constant and cannot be changed!',
              style: TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          // Username Field
          TextFormField(
            key: _thisUsername,
            decoration: InputDecoration(
              // Label Text
              labelText: 'Username',
            ),
            // Declare Initial Value
            initialValue: username,
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
            ),
            // Declare Initial Value
            initialValue: phoneNumber,
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
                // Update the data
                await DatabaseService(uid: firebaseUser.uid).updateUserInfo(
                    email,
                    _thisUsername.currentState.value,
                    int.parse(_thisPhoneNumber.currentState.value));
                // Refresh the page
                editProfileSuccessDialog(context);
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
// End of Edit Profile Form

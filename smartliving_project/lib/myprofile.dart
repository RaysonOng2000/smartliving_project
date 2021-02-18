import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartliving_project/authenication.dart';
import 'package:smartliving_project/dbdata.dart';

// Import pages
import 'editprofile.dart';
import 'changepassword.dart';
import 'about.dart';
import 'welcome.dart';

// Profile Body
class ProfileBody extends StatelessWidget {
  ProfileBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Retrieve current user logged in
    final firebaseUser = context.watch<User>();
    // Variable to retrieve the user data
    final dataList = Provider.of<List<DatabaseData>>(context) ?? [];
    String email = '';
    String username = '';
    String phoneNumber = '';

    // Retrieve all user records
    dataList.forEach((data) {
      // Check if the user email is equal to the current user's email
      if (firebaseUser.email == data.email) {
        email = data.email;
        username = data.username;
        phoneNumber = data.phoneNumber.toString();
      }
    });

    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        // Account Info Section
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 25.0,
            horizontal: 15.0,
          ),
          color: Colors.grey[200],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.account_box,
                size: 75.0,
                color: Colors.indigo,
              ),
              SizedBox(
                width: 20.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Username
                  Text(
                    username,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // End of Username
                  SizedBox(
                    height: 2.5,
                  ),
                  // Email Info
                  Text(
                    email,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                  // End of Email Info
                ],
              ),
            ],
          ),
        ),
        // End of Account Info Section
        // Button Section
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 15.0,
            horizontal: 0.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Edit Profile Button
              ProfileFlatButton(
                Icons.edit_outlined,
                'Edit Profile',
                'Update your username and phone number',
                EditProfilePage(email, username, phoneNumber),
              ),
              // Change Password Button
              ProfileFlatButton(
                Icons.lock_outlined,
                'Change Password',
                'Update your password',
                ChangePasswordPage(),
              ),
              // About Button
              ProfileFlatButton(
                Icons.info_outlined,
                'About',
                'Infomation about the application',
                AboutPage(),
              ),
              // Logout Button
              ProfileFlatButton(
                Icons.exit_to_app_outlined,
                'Logout',
                'Sign out from your account',
                WelcomePage(),
                isLogout: true,
              ),
            ],
          ),
        ),
        // End of Button Section
      ],
    );
  }
}
// End of Profile Body

// Profile Flat Button
class ProfileFlatButton extends StatelessWidget {
  final IconData icon;
  final String name;
  final String description;
  final bool isLogout;
  final Widget page;

  ProfileFlatButton(this.icon, this.name, this.description, this.page,
      {Key key, this.isLogout = false});

  // Logout Dialog
  Future logoutDialog(BuildContext context, Widget pg) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // Display title
          title: Text('Logout'),
          // Display message
          content: Text('Do you want to logout?'),
          // Actions
          actions: [
            // Yes Button
            FlatButton(
              onPressed: () {
                // Close the alert dialog
                Navigator.pop(context);
                // Logout User
                context.read<AuthenicationService>().logOut();
              },
              child: Text(
                'Yes',
                style: TextStyle(color: Colors.indigo),
              ),
            ),
            // End of Yes Button
            // No Button
            FlatButton(
              onPressed: () {
                // Close the alert dialog
                Navigator.pop(context);
              },
              child: Text(
                'No',
                style: TextStyle(color: Colors.indigo),
              ),
            ),
            // End of No Button
          ],
          elevation: 5.0,
        );
      },
    );
  }
  // End of Logout Dialog

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      highlightColor: Colors.grey[300],
      // On pressed
      onPressed: () {
        // If it is not a logout button
        if (!isLogout) {
          // Go to the desired page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => page,
            ),
          );
        } else {
          // Logout Dialog
          logoutDialog(context, page);
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Icon
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Icon(
              this.icon,
              color: isLogout ? Colors.red[400] : Colors.grey[700],
              size: 35.0,
            ),
          ),
          // End of Icon
          SizedBox(
            width: 30.0,
          ),
          // Page Name and Description
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Page Name
              Text(
                this.name,
                style: TextStyle(
                  color: isLogout ? Colors.red : Colors.black,
                  fontSize: 16.0,
                ),
              ),
              // End of Page Name
              SizedBox(
                height: 2.5,
              ),
              // Description
              Text(
                description,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: isLogout ? Colors.red : Colors.grey,
                  fontSize: 14.0,
                ),
              ),
              // End of Description
            ],
          ),
          // End of Page Name and Description
        ],
      ),
    );
  }
}
// End of Profile Flat Button

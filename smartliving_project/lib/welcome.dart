import 'package:flutter/material.dart';

// Import pages
import 'register.dart';
import 'login.dart';

// Welcome Page
class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Body Section
      body: Center(
        child: ListView(
          padding: const EdgeInsets.symmetric(
            vertical: 50.0,
            horizontal: 15.0,
          ),
          shrinkWrap: true,
          children: <Widget>[
            // Logo
            // Image.asset(
            //   'images/logo/Logo.png',
            //   width: 200,
            //   height: 200,
            // ),
            Icon(
              Icons.home,
              color: Colors.indigo,
              size: 150.0,
            ),
            // End of Logo
            SizedBox(
              height: 15.0,
            ),
            // Heading and Paragraph
            Text(
              'Welcome to Smart Living',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Are you ready to start and evolve your home into the next generation of technology?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            // End of Heading and Paragraph
            SizedBox(
              height: 70,
            ),
            // Login Button
            RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
              highlightElevation: 5.0,
              elevation: 5.0,
              child: Text(
                'Login Account',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            // End of Login Button
            SizedBox(
              height: 20,
            ),
            // Register Button
            RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterPage(),
                  ),
                );
              },
              color: Colors.deepOrange,
              highlightColor: Colors.deepOrange[200],
              highlightElevation: 5.0,
              elevation: 5.0,
              child: Text(
                'Register an Account',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            // End of Register Button
          ],
        ),
      ),
      // End of Body Section
    );
  }
}
// End of Welcome Page

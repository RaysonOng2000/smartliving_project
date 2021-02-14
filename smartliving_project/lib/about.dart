import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// About Page
class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App Bar
      appBar: AppBar(
        title: Text(
          'About',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      // End of App Bar
      // Body Section
      body: ListView(
        padding: const EdgeInsets.symmetric(
          vertical: 50.0,
          horizontal: 15.0,
        ),
        shrinkWrap: true,
        children: <Widget>[
          // Our Application Section
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Heading
                Text(
                  'Our Application',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                // End of Heading
                SizedBox(
                  height: 10,
                ),
                // Paragraph
                Text(
                  'Smart Living uses home technology such as lights, doors and air conditioner to be able to control them using smartphones.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                // End of Paragraph
              ],
            ),
          ),
          // End of Our Application Section
          SizedBox(
            height: 30,
          ),
          // Our Company Section
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Heading
                Text(
                  'Our Company',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                // End of Heading
                SizedBox(
                  height: 10,
                ),
                // Paragraph
                Text(
                  'Smart Living is founded in 2020 by Rayson Ong. As technology advanced, our life will become easier so it was founded as we want to provide people in helping them to have a better life by upgrading their homes with smart technology as to make life easier.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                // End of Paragraph
              ],
            ),
          ),
          // End of Our Company Section
          SizedBox(
            height: 30,
          ),
          // Contact Us Section
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Heading
                Text(
                  'Contact Us',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                // End of Heading
                SizedBox(
                  height: 10,
                ),
                // Paragraph
                Text(
                  'Rayson Ong',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                ContactButton('tel', '+65 9386 5063'),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Smart Living',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                ContactButton('tel', '+65 6580 1234'),
                ContactButton('mailto', 'email@smartliving.com'),
                // End of Paragraph
              ],
            ),
          ),
          // End of Contact Us Section
        ],
      ),
      // End of Body Section
    );
  }
}
// End of About Page

// Contact Button
class ContactButton extends StatelessWidget {
  final String contactType;
  final String url;

  ContactButton(this.contactType, this.url);

  // Launch contact number or email
  void launchContact(command) async {
    // If able to launch
    if (await canLaunch(command)) {
      await launch(command);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: EdgeInsets.all(0.0),
      onPressed: () => launchContact(contactType + ":" + url),
      child: Text(
        url,
        style: TextStyle(
          fontSize: 16,
          color: Colors.indigo,
        ),
      ),
    );
  }
}
// End of Contact Button

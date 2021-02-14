import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartliving_project/authenication.dart';
import 'package:smartliving_project/database.dart';
import 'package:smartliving_project/dbdata.dart';

// Import pages
import 'myprofile.dart';
import 'room.dart';

// Main Page
class MainPage extends StatefulWidget {
  final User firebaseUser;

  // Constructor for passing the login email and username
  MainPage(this.firebaseUser, {Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState(this.firebaseUser);
}

class _MainPageState extends State<MainPage> {
  User firebaseUser;
  String title = 'Smart Living';
  int index = 0;
  List<Widget> navList;

  // Constructer to get email, username and to pass to another page body
  _MainPageState(this.firebaseUser) {
    navList = [HomeBody(), ProfileBody()];
  }
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<DatabaseData>>.value(
      value: DatabaseService().userInfo,
      child: Scaffold(
        // App Bar
        appBar: AppBar(
          title: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // End of App Bar
        // Body
        body: navList[index],
        // End of Body
        // Drawer
        drawer: NavDrawer(
          onTap: (context, i, txt) {
            setState(
              () {
                // Assign the values for index and title
                index = i;
                title = txt;
                // Close the drawer
                Navigator.pop(context);
              },
            );
          },
        ),
        // End of Drawer
      ),
    );
  }
}
// End of Main Page

// Home Body
class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GridView.count(
        padding: const EdgeInsets.symmetric(
          vertical: 30.0,
          horizontal: 15.0,
        ),
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        crossAxisCount: 2,
        shrinkWrap: true,
        children: <Widget>[
          // Living Room Button
          RoomButton('Living Room', Icons.tv),
          // Bed Room Button
          RoomButton('Bed Room', Icons.king_bed_outlined),
          // Kitchen Button
          RoomButton('Kitchen', Icons.kitchen),
          // Bath Room Button
          RoomButton('Bath Room', Icons.bathtub_outlined),
          // Store Room Button
          RoomButton('Store Room', Icons.storage_outlined),
        ],
      ),
    );
  }
}
// End of Home Body

// Room Button
class RoomButton extends StatefulWidget {
  final String roomName;
  final IconData icon;

  RoomButton(this.roomName, this.icon, {Key key}) : super(key: key);

  @override
  _RoomButtonState createState() => _RoomButtonState(roomName, icon);
}

class _RoomButtonState extends State<RoomButton> {
  String roomName;
  IconData icon;

  _RoomButtonState(this.roomName, this.icon);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        // Go to the desired page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RoomPage(roomName),
          ),
        );
      },
      color: Colors.grey[100],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Room Icon
          Icon(
            icon,
            size: 50.0,
            color: Colors.indigo,
          ),
          // End of Room Icon
          SizedBox(
            height: 15.0,
          ),
          // Room Name
          Text(
            roomName,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          // End of Room Name
        ],
      ),
    );
  }
}
// End of Room Button

// Nav Drawer
class NavDrawer extends StatelessWidget {
  final Function onTap;

  // Constructor for onTap function
  NavDrawer({Key key, this.onTap});

  // Logout Dialog
  Future logoutDialog(BuildContext context) async {
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
    final dataList = Provider.of<List<DatabaseData>>(context) ?? [];
    String email = '';
    String username = '';

    dataList.forEach((data) {
      email = data.email;
      username = data.username;
    });

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.75,
      child: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Drawer Header
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.indigo,
              ),
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    // Username and Email
                    Text(
                      username,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 2.5,
                    ),
                    Text(
                      email,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    // End of username and email
                  ],
                ),
              ),
            ),
            // End of Drawer Header
            // Nav List
            ListTile(
              leading: Icon(
                Icons.home_outlined,
                color: Colors.grey[700],
              ),
              title: Text('Home'),
              onTap: () => onTap(context, 0, 'Smart Living'),
            ),
            ListTile(
              leading: Icon(
                Icons.person_outline_sharp,
                color: Colors.grey[700],
              ),
              title: Text('My Profile'),
              onTap: () => onTap(context, 1, 'My Profile'),
            ),
            ListTile(
              leading: Icon(
                Icons.exit_to_app_outlined,
                color: Colors.red[400],
              ),
              title: Text(
                'Logout',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              onTap: () => logoutDialog(context),
            ),
            // End of Nav List
          ],
        ),
      ),
    );
  }
}
// End of Nav Drawer

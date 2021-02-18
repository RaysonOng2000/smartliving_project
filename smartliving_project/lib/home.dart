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
      // Retrieve User Info
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
          RoomButton('Living Room', Icons.tv, 3),
          // Bed Room Button
          RoomButton('Bed Room', Icons.king_bed_outlined, 3),
          // Kitchen Button
          RoomButton('Kitchen', Icons.kitchen, 1),
          // Bath Room Button
          RoomButton('Bath Room', Icons.bathtub_outlined, 1),
          // Store Room Button
          RoomButton('Store Room', Icons.storage_outlined, 1),
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
  final int numOfDevices;

  RoomButton(this.roomName, this.icon, this.numOfDevices, {Key key})
      : super(key: key);

  @override
  _RoomButtonState createState() =>
      _RoomButtonState(roomName, icon, numOfDevices);
}

class _RoomButtonState extends State<RoomButton> {
  String roomName;
  IconData icon;
  int numofDevices;

  _RoomButtonState(this.roomName, this.icon, this.numofDevices);

  @override
  Widget build(BuildContext context) {
    // Assign message for number of devices
    String numOfDevicesMsg = numofDevices.toString() + ' device';

    // Add an "s" at the end of the message if more than 1 device in a room
    if (numofDevices > 1) {
      numOfDevicesMsg += 's';
    }

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
          SizedBox(
            height: 2.5,
          ),
          // Number of Devices Text
          Text(
            numOfDevicesMsg,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          // End of Number of Devices Text
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
    // Retrieve current user logged in
    final firebaseUser = context.watch<User>();
    // Variable to retrieve the user data
    final dataList = Provider.of<List<DatabaseData>>(context) ?? [];
    String email = '';
    String username = '';

    // Retrieve all user records
    dataList.forEach((data) {
      // Check if the user email is equal to the current user's email
      if (firebaseUser.email == data.email) {
        email = data.email;
        username = data.username;
      }
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
                    // Username
                    Text(
                      username,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    // End of Username
                    SizedBox(
                      height: 2.5,
                    ),
                    // Email
                    Text(
                      email,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    // End of Email
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

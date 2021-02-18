import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartliving_project/database.dart';
import 'package:smartliving_project/dbdata.dart';
import 'package:smartliving_project/dbdevicestatus.dart';

// Import pages
import 'device.dart';

// Room Page
class RoomPage extends StatelessWidget {
  final String roomName;

  RoomPage(this.roomName);

  // Light Button
  Widget lightButton() {
    return DeviceButton("Lights");
  }
  // End of Light Button

  // Television Button
  Widget televisionButton() {
    return DeviceButton("Television");
  }
  // End of Television Button

  // Air Conditioner Button
  Widget airConditionerButton() {
    return DeviceButton("Air Conditioner");
  }
  // End of Air Conditioner Button

  // Door Button
  Widget doorButton() {
    return DeviceButton("Door");
  }
  // End of Door Button

  // Device List Function
  Widget deviceList(roomName) {
    switch (roomName) {
      case "Living Room":
        return Column(
          children: <Widget>[
            televisionButton(),
            lightButton(),
            doorButton(),
          ],
        );
        break;
      case "Bed Room":
        return Column(
          children: <Widget>[
            televisionButton(),
            lightButton(),
            airConditionerButton(),
          ],
        );
        break;
      case "Kitchen":
        return Column(
          children: <Widget>[
            lightButton(),
          ],
        );
        break;
      case "Bath Room":
        return Column(
          children: <Widget>[
            lightButton(),
          ],
        );
        break;
      case "Store Room":
        return Column(
          children: <Widget>[
            lightButton(),
          ],
        );
        break;
      default:
        return Column();
    }
  }
  // End of Device List Function

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Retrieve Device Status
        StreamProvider<List<DatabaseDeviceStatus>>.value(
          value: DatabaseService().deviceStatus,
        ),
        // Retrieve User Info
        StreamProvider<List<DatabaseData>>.value(
          value: DatabaseService().userInfo,
        ),
      ],
      child: Scaffold(
        // App Bar
        appBar: AppBar(
          title: Text(
            roomName,
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
            deviceList(roomName),
            SizedBox(
              height: 30.0,
            ),
            // Turn off All Device Button
            RaisedButton(
              color: Colors.red,
              highlightColor: Colors.red[200],
              onPressed: () {},
              highlightElevation: 5.0,
              elevation: 5.0,
              child: Text(
                'Turn Off All Device',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            // End of Turn off All Device Button
          ],
        ),
        // End of Body Section
      ),
    );
  }
}
// End of Room Page

// Device Button
class DeviceButton extends StatefulWidget {
  final String deviceName;

  DeviceButton(this.deviceName, {Key key}) : super(key: key);

  @override
  _DeviceButtonState createState() => _DeviceButtonState(deviceName);
}

class _DeviceButtonState extends State<DeviceButton> {
  String deviceName;
  bool _switchValue = false;

  _DeviceButtonState(this.deviceName);

  @override
  Widget build(BuildContext context) {
    // Retrieve current user logged in
    final firebaseUser = context.watch<User>();
    // Variable to retrieve the device records
    final dataList = Provider.of<List<DatabaseDeviceStatus>>(context) ?? [];
    // Assigning
    bool isAirConditionerOn = false;
    bool isLightOn = false;
    bool isDoorOn = false;
    bool isTvOn = false;
    // For Identification purpose
    String email = firebaseUser.email;
    // For displaying status
    String statusMsg = '';

    dataList.forEach((data) {
      if (email == data.email) {
        isAirConditionerOn = data.isAirConditionerOn;
        isLightOn = data.isLightOn;
        isDoorOn = data.isDoorOn;
        isTvOn = data.isTvOn;
      }
    });

    // Assign inputs
    switch (deviceName) {
      case "Air Conditioner":
        _switchValue = isAirConditionerOn;
        break;
      case "Lights":
        _switchValue = isLightOn;
        break;
      case "Door":
        _switchValue = isDoorOn;
        break;
      case "Television":
        _switchValue = isTvOn;
        break;
    }

    // Check for switch status to display message
    if (_switchValue) {
      statusMsg = 'ON';
    } else {
      statusMsg = 'OFF';
    }

    return Padding(
      padding: EdgeInsets.only(bottom: 15.0),
      child: RaisedButton(
        onPressed: () {
          // Go to the device page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DevicePage(deviceName),
            ),
          );
        },
        color: Colors.grey[100],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Device Name
                  Text(
                    deviceName,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  // End of Device Name
                  SizedBox(
                    height: 5.0,
                  ),
                  // Status
                  Text(
                    statusMsg,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  // End of Status
                ],
              ),
            ),
            // End of Icon and Name
            // Switch Toggle
            Switch(
              activeColor: Colors.indigo,
              value: _switchValue,
              onChanged: (val) async {
                // Check the device that has been toggled
                switch (deviceName) {
                  case "Air Conditioner":
                    isAirConditionerOn = val;
                    break;
                  case "Lights":
                    isLightOn = val;
                    break;
                  case "Door":
                    isDoorOn = val;
                    break;
                  case "Television":
                    isTvOn = val;
                    break;
                }
                // Update status
                await DatabaseService(uid: firebaseUser.uid).updateDeviceStatus(
                  firebaseUser.email,
                  isAirConditionerOn,
                  isLightOn,
                  isDoorOn,
                  isTvOn,
                );

                // Update the toggle state
                setState(() {
                  _switchValue = val;
                });
              },
            ),
            // End of Switch Toggle
          ],
        ),
      ),
    );
  }
}
// End of Device Button

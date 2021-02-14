import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    'Connected',
                    style: TextStyle(
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
              onChanged: (val) {
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

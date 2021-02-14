import 'package:flutter/material.dart';

// Device Page
class DevicePage extends StatelessWidget {
  final String deviceName;

  DevicePage(this.deviceName);

  Widget deviceSetting(deviceName) {
    switch (deviceName) {
      case "Television":
        return TVForm();
        break;
      case "Lights":
        return LightsForm();
        break;
      case "Door":
        return DoorForm();
        break;
      case "Air Conditioner":
        return AirConditionerForm();
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
          deviceName,
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
          deviceSetting(deviceName),
        ],
      ),
      // End of Body Section
    );
  }
}
// End of Device Page

// TV Form
class TVForm extends StatefulWidget {
  TVForm({Key key}) : super(key: key);

  @override
  _TVFormState createState() => _TVFormState();
}

class _TVFormState extends State<TVForm> {
  final _formKey = GlobalKey<FormState>();
  bool _switchValue = false;
  double _volumeValue = 0;
  double _brightnessValue = 0;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Switch Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // Switch Text
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  'Switch',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
              // End of Switch Text
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
          // End of Switch Row
          SizedBox(
            height: 30.0,
          ),
          // Brightness Row
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Brightness Text
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  'Brightness',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
              // End of Brightness Text
              // Brightness Slider
              Slider(
                activeColor: Colors.indigo,
                inactiveColor: Colors.grey[200],
                value: _brightnessValue,
                min: 0,
                max: 100,
                divisions: 100,
                label: _brightnessValue.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _brightnessValue = value;
                  });
                },
              ),
              // End of Brightness Slider
            ],
          ),
          // End of Brightness Row
          SizedBox(
            height: 30.0,
          ),
          // Volume Row
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Volume Text
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  'Volume',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
              // End of Volume Text
              // Volume Slider
              Slider(
                activeColor: Colors.indigo,
                inactiveColor: Colors.grey[200],
                value: _volumeValue,
                min: 0,
                max: 100,
                divisions: 100,
                label: _volumeValue.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _volumeValue = value;
                  });
                },
              ),
              // End of Volume Slider
            ],
          ),
          // End of Volume Row
        ],
      ),
    );
  }
}
// End of TV Form

// Lights Form
class LightsForm extends StatefulWidget {
  LightsForm({Key key}) : super(key: key);

  @override
  _LightsFormState createState() => _LightsFormState();
}

class _LightsFormState extends State<LightsForm> {
  final _formKey = GlobalKey<FormState>();
  bool _switchValue = false;
  double _brightnessValue = 0;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Switch Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // Switch Text
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  'Switch',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
              // End of Switch Text
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
          // End of Switch Row
          SizedBox(
            height: 30.0,
          ),
          // Brightness Row
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Brightness Text
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  'Brightness',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
              // End of Brightness Text
              // Brightness Slider
              Slider(
                activeColor: Colors.indigo,
                inactiveColor: Colors.grey[200],
                value: _brightnessValue,
                min: 0,
                max: 100,
                divisions: 100,
                label: _brightnessValue.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _brightnessValue = value;
                  });
                },
              ),
              // End of Brightness Slider
            ],
          ),
          // End of Brightness Row
        ],
      ),
    );
  }
}
// End of Lights Form

// Door Form
class DoorForm extends StatefulWidget {
  DoorForm({Key key}) : super(key: key);

  @override
  _DoorFormState createState() => _DoorFormState();
}

class _DoorFormState extends State<DoorForm> {
  final _formKey = GlobalKey<FormState>();
  bool _switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Door Status Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // Door Status Text
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  'Door Status',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
              // End of  Door Status Text
              // Door Status Toggle
              Switch(
                activeColor: Colors.indigo,
                value: _switchValue,
                onChanged: (val) {
                  setState(() {
                    _switchValue = val;
                  });
                },
              ),
              // End of Door Status Toggle
            ],
          ),
          // End of Door Status Row
        ],
      ),
    );
  }
}
// End of Door Form

// Air Conditioner Form
class AirConditionerForm extends StatefulWidget {
  AirConditionerForm({Key key}) : super(key: key);

  @override
  _AirConditionerFormState createState() => _AirConditionerFormState();
}

class _AirConditionerFormState extends State<AirConditionerForm> {
  final _formKey = GlobalKey<FormState>();
  bool _switchValue = false;
  double _airConditionerValue = 0;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Switch Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // Switch Text
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  'Switch',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
              // End of Switch Text
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
          // End of Switch Row
          SizedBox(
            height: 30.0,
          ),
          // Temperature Row
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Temperature Text
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  'Temperature',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
              // End of Temperature Text
              // Temperature Slider
              Slider(
                activeColor: Colors.indigo,
                inactiveColor: Colors.grey[200],
                value: _airConditionerValue,
                min: 0,
                max: 30,
                divisions: 30,
                label: _airConditionerValue.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _airConditionerValue = value;
                  });
                },
              ),
              // End of Temperature Slider
            ],
          ),
          // End of Temperature Row
        ],
      ),
    );
  }
}
// End of Air Conditioner Form

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartliving_project/database.dart';
import 'package:smartliving_project/dbdata.dart';
import 'package:smartliving_project/dbdevicestatus.dart';

// Device Page
class DevicePage extends StatelessWidget {
  final String deviceName;

  DevicePage(this.deviceName);

  Widget deviceSetting(deviceName) {
    switch (deviceName) {
      case "Television":
        return TVForm(deviceName);
        break;
      case "Lights":
        return LightsForm(deviceName);
        break;
      case "Door":
        return DoorForm(deviceName);
        break;
      case "Air Conditioner":
        return AirConditionerForm(deviceName);
        break;
      default:
        return Column();
    }
  }

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
      ),
    );
  }
}
// End of Device Page

// Switch Toggle
class SwitchToggle extends StatefulWidget {
  final String text;
  final String deviceName;

  SwitchToggle(this.text, this.deviceName, {Key key}) : super(key: key);

  @override
  _SwitchToggleState createState() =>
      _SwitchToggleState(this.text, this.deviceName);
}

class _SwitchToggleState extends State<SwitchToggle> {
  String text;
  String deviceName;

  _SwitchToggleState(this.text, this.deviceName);

  @override
  Widget build(BuildContext context) {
    // Retrieve current user logged in
    final firebaseUser = context.watch<User>();
    // Variable to retrieve the device records
    final dataList = Provider.of<List<DatabaseDeviceStatus>>(context) ?? [];
    // For current value of the switch
    bool _switchValue = false;
    // Assigning
    bool isAirConditionerOn = false;
    bool isLightOn = false;
    bool isDoorOn = false;
    bool isTvOn = false;
    // For Identification purpose
    String email = firebaseUser.email;

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

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        // Switch Text
        Padding(
          padding: EdgeInsets.only(left: 15.0),
          child: Text(
            text,
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
    );
  }
}
// End of Switch Toggle

// Slider Bar
class SliderBar extends StatefulWidget {
  final String text;
  final double min;
  final double max;
  final int divisions;

  SliderBar(this.text, this.min, this.max, this.divisions, {Key key})
      : super(key: key);

  @override
  _SliderBarState createState() =>
      _SliderBarState(this.text, this.min, this.max, this.divisions);
}

class _SliderBarState extends State<SliderBar> {
  String text;
  double min;
  double max;
  int divisions;
  double _sliderValue = 0;

  _SliderBarState(this.text, this.min, this.max, this.divisions);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Slider Text
        Padding(
          padding: EdgeInsets.only(left: 15.0),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
        ),
        // End of Slider Text
        // Slider
        Slider(
          activeColor: Colors.indigo,
          inactiveColor: Colors.grey[200],
          value: _sliderValue,
          min: min,
          max: max,
          divisions: divisions,
          label: _sliderValue.round().toString(),
          onChanged: (double value) {
            setState(() {
              _sliderValue = value;
            });
          },
        ),
        // End of Slider
      ],
    );
  }
}
// End of Slider Bar

// TV Form
class TVForm extends StatefulWidget {
  final String deviceName;

  TVForm(this.deviceName, {Key key}) : super(key: key);

  @override
  _TVFormState createState() => _TVFormState(this.deviceName);
}

class _TVFormState extends State<TVForm> {
  final _formKey = GlobalKey<FormState>();
  String deviceName;

  _TVFormState(this.deviceName);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Switch Toggle
          SwitchToggle('Power', deviceName),
          // End of Switch Toggle
          SizedBox(
            height: 30.0,
          ),
          // Brightness Row
          SliderBar('Brightness', 0, 100, 100),
          // End of Brightness Row
          SizedBox(
            height: 30.0,
          ),
          // Contrast Row
          SliderBar('Contrast', 0, 100, 100),
          // End of Contrast Row
          SizedBox(
            height: 30.0,
          ),
          // Sharpness Row
          SliderBar('Sharpness', 0, 100, 100),
          // End of Sharpness Row
          SizedBox(
            height: 30.0,
          ),
          // Volume Row
          SliderBar('Volume', 0, 100, 100),
          // End of Volume Row
        ],
      ),
    );
  }
}
// End of TV Form

// Lights Form
class LightsForm extends StatefulWidget {
  final String deviceName;

  LightsForm(this.deviceName, {Key key}) : super(key: key);

  @override
  _LightsFormState createState() => _LightsFormState(this.deviceName);
}

class _LightsFormState extends State<LightsForm> {
  final _formKey = GlobalKey<FormState>();
  String deviceName;

  _LightsFormState(this.deviceName);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Switch Toggle
          SwitchToggle('Power', this.deviceName),
          // End of Switch Toggle
          SizedBox(
            height: 30.0,
          ),
          // Brightness Row
          SliderBar('Brightness', 0, 100, 100),
          // End of Brightness Row
        ],
      ),
    );
  }
}
// End of Lights Form

// Door Form
class DoorForm extends StatefulWidget {
  final String deviceName;

  DoorForm(this.deviceName, {Key key}) : super(key: key);

  @override
  _DoorFormState createState() => _DoorFormState(this.deviceName);
}

class _DoorFormState extends State<DoorForm> {
  final _formKey = GlobalKey<FormState>();
  String deviceName;

  _DoorFormState(this.deviceName);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Switch Toggle
          SwitchToggle('Door Lock', this.deviceName),
          // End of Switch Toggle
        ],
      ),
    );
  }
}
// End of Door Form

// Air Conditioner Form
class AirConditionerForm extends StatefulWidget {
  final String deviceName;

  AirConditionerForm(this.deviceName, {Key key}) : super(key: key);

  @override
  _AirConditionerFormState createState() =>
      _AirConditionerFormState(this.deviceName);
}

class _AirConditionerFormState extends State<AirConditionerForm> {
  final _formKey = GlobalKey<FormState>();
  String deviceName;

  _AirConditionerFormState(this.deviceName);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Switch Toggle
          SwitchToggle('Power', this.deviceName),
          // End of Switch Toggle
          SizedBox(
            height: 30.0,
          ),
          // Fan Speed Row
          SliderBar('Fan Speed', 0, 100, 100),
          // End of Fan Speed Row
          SizedBox(
            height: 30.0,
          ),
          // Temperature Row
          SliderBar('Temperature (°C)', 0, 30, 30),
          // End of Temperature Row
        ],
      ),
    );
  }
}
// End of Air Conditioner Form

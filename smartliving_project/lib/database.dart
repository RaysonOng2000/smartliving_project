import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartliving_project/dbdata.dart';
import 'package:smartliving_project/dbdevicestatus.dart';

class DatabaseService {
  final String uid;
  final CollectionReference _userList =
      FirebaseFirestore.instance.collection("userInfo");
  final CollectionReference _deviceStatus =
      FirebaseFirestore.instance.collection("deviceStatus");

  DatabaseService({this.uid});

  // Update User Info Function
  Future updateUserInfo(String email, String username, int phoneNumber) async {
    return await _userList.doc(uid).set({
      'email': email,
      'username': username,
      'phoneNumber': phoneNumber,
    });
  }

  // Update Device Status Function
  Future updateDeviceStatus(String email, bool isAirConditionerOn,
      bool isLightOn, bool isDoorOn, bool isTvOn) async {
    return await _deviceStatus.doc(uid).set({
      'email': email,
      'isAirConditionerOn': isAirConditionerOn,
      'isLightOn': isLightOn,
      'isDoorOn': isDoorOn,
      'isTvOn': isTvOn,
    });
  }

  List<DatabaseData> _userInfoFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return DatabaseData(
        email: doc.data()['email'] ?? '',
        username: doc.data()['username'] ?? '',
        phoneNumber: doc.data()['phoneNumber'] ?? 0,
      );
    }).toList();
  }

  List<DatabaseDeviceStatus> _deviceStatusFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return DatabaseDeviceStatus(
        email: doc.data()['email'] ?? '',
        isAirConditionerOn: doc.data()['isAirConditionerOn'] ?? false,
        isLightOn: doc.data()['isLightOn'] ?? false,
        isDoorOn: doc.data()['isDoorOn'] ?? false,
        isTvOn: doc.data()['isTvOn'] ?? false,
      );
    }).toList();
  }

  // Get User Info Function
  Stream<List<DatabaseData>> get userInfo {
    return _userList.snapshots().map(_userInfoFromSnapshot);
  }

  // Get Device Status Function
  Stream<List<DatabaseDeviceStatus>> get deviceStatus {
    return _deviceStatus.snapshots().map(_deviceStatusFromSnapshot);
  }
}

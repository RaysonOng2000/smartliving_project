import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartliving_project/dbdata.dart';

class DatabaseService {
  final String uid;
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection("smartliving");

  DatabaseService({this.uid});

  // Update User Info Function
  Future updateUserInfo(String email, String username, int phoneNumber) async {
    return await _collection.doc(uid).set({
      'email': email,
      'username': username,
      'phoneNumber': phoneNumber,
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

  // Get User Info Function
  Stream<List<DatabaseData>> get userInfo {
    return _collection.snapshots().map(_userInfoFromSnapshot);
  }
}

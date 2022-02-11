import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

class Users {
  Users({
    required this.email,
    required this.password,
  });
  String email;
  String password;
}

Future<void> saveData() async {}

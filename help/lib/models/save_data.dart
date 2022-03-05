import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

class Users {
  Users({
    required this.email,
    required this.password,
  });

  String email;
  String password;
  String? name;
  String? data;
  String? cpf;
  String? id;

  DocumentReference get firestoreRef => db.doc('users/$id');

  Future<void> saveData() async {
    await firestoreRef.set(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
    };
  }
}

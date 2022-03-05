import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

class Users {
  Users({
    required this.email,
    required this.password,
    this.cpf,
    this.name,
    this.id,
    this.data,
  });
  Users.fromDocument(DocumentSnapshot document) {
    Map dados = document.data() as Map;
    id = document.id;
    name = dados['name'] as String;
    email = dados['email'] as String;
    cpf = dados['cpf'] as String;
    data = dados['data'] as String;
  }

  late String email;
  late String password;
  String? name;
  String? data;
  String? cpf;
  String? id;

  DocumentReference get ref => db.doc('users/$id');

  Future<void> saveData() async {
    await ref.set(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'data': data,
      'cpf': cpf,
    };
  }
}

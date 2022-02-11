import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:help/screens_comuns/base_screen.dart';

chamado() async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  db
      .collection("usuarios")
      .doc("001")
      .collection("Anjos")
      .doc("002")
      .update({"statusChamado": true});

  pageController.jumpToPage(3);
}

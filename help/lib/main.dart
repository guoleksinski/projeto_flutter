import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:help/screens_comuns/base_screen.dart';
import 'package:provider/provider.dart';
import 'models/user_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => UserManager(),
        child: MaterialApp(
          title: 'Help',
          debugShowCheckedModeBanner: false,
          home: const BaseScreen(),
          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.green,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.blueGrey,
          ),
        ));
  }
}

//Método para verificar chamado

verificarChamado() async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  DocumentSnapshot snapshot = await db
      .collection("usuarios")
      .doc("001")
      .collection("Anjos")
      .doc("002")
      .get();
  var dados = snapshot['statusChamado'];
  if (dados == true) {
    if (pageController.page?.toInt() != 1) {
      pageController.jumpToPage(1);
    }
  } else if (dados == false) {
    if (pageController.page?.toInt() == 1) {
      pageController.jumpToPage(0);
    }
  }
}

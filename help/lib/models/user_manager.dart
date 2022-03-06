import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:help/helpers/firebase_errors.dart';
import 'package:help/models/user.dart';
import 'package:help/screens_comuns/base_screen.dart';

class UserManager extends ChangeNotifier {
  //verifica se o usuario esta logado
  UserManager() {
    _loadCurrentUser();
  }
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  late User user;
  late Users users;

  bool loading = false;

  Future<void> signIn(
      {required Users user, Function? onFail, Function? onSuccess}) async {
    setLoading(true);
    //faz o login
    try {
      final UserCredential result = await auth.signInWithEmailAndPassword(
          email: user.email, password: user.password);

      await _loadCurrentUser(firebaseUser: result.user!);
      //salva o usuario
      this.user = result.user!;
      onSuccess!();
    } on FirebaseAuthException catch (e) {
      onFail!(getErrorString(e.code));
    }
    setLoading(false);
  }

//verifica se esta carregando
  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

//verifica se o usuario esta logado
  Future<void> _loadCurrentUser({User? firebaseUser}) async {
    final User? currentUser = auth.currentUser;
    if (currentUser != null) {
      final DocumentSnapshot docUser =
          await firestore.collection('users').doc(currentUser.uid).get();
      users = Users.fromDocument(docUser);
      pageController.jumpToPage(2);
    }
    notifyListeners();
  }

  Future<void> signUp(
      {required Users user,
      required Function onFail,
      required Function onSuccess}) async {
    loading = true;
    try {
      final UserCredential result = await auth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);

      this.user = result.user!;
      user.id = result.user?.uid;
      this.users = user;

      await user.saveData();
      onSuccess();
    } on FirebaseAuthException catch (e) {
      onFail(getErrorString(e.code));
    }
    loading = false;
  }
}

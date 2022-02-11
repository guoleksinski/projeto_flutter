import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:help/helpers/firebase_errors.dart';
import 'package:help/models/user.dart';

class UserManager extends ChangeNotifier {
  //verifica se o usuario esta logado
  UserManager() {
    _loadCurrentUser();
  }
  final FirebaseAuth auth = FirebaseAuth.instance;

  late User user;

  bool loading = false;

  Future<void> signIn(
      {required Users user, Function? onFail, Function? onSuccess}) async {
    setLoading(true);
    //faz o login
    try {
      final UserCredential result = await auth.signInWithEmailAndPassword(
          email: user.email, password: user.password);
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
  Future<void> _loadCurrentUser() async {
    final User? currentUser = auth.currentUser;
    if (currentUser != null) {
      user = currentUser;
    }
    notifyListeners();
  }

  Future<void> signUp({
    required Users user,
    required Function onFail,
    required Function onSuccess,
  }) async {
    setLoading(true);
    try {
      final UserCredential result = await auth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);
      this.user = result.user!;
      saveData();
      onSuccess();
    } on FirebaseAuthException catch (e) {
      onFail(getErrorString(e.code));
    }
    setLoading(false);
  }
}

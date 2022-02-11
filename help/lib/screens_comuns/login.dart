import 'package:flutter/material.dart';
import 'package:help/helpers/validators.dart';
import 'package:help/models/user.dart';
import 'package:help/models/user_manager.dart';
import 'package:help/widgets/alerts.dart';
import 'package:provider/provider.dart';
import '../widgets/alerts.dart';

import 'base_screen.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final TextEditingController _email = TextEditingController();
final TextEditingController _pass = TextEditingController();

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(top: 200),
            child: Consumer<UserManager>(builder: (_, userManager, __) {
              return ListView(
                padding: const EdgeInsets.all(16),
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Icon(
                    Icons.person,
                    color: Colors.green,
                    size: 100,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Center(
                        child: TextFormField(
                          enabled: !userManager.loading,
                          controller: _email,
                          decoration: const InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              )),
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          validator: (email) {
                            if (!emailValid(email!)) {
                              return 'E-mail inválido';
                            } else {
                              return null;
                            }
                          },
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Center(
                        child: TextFormField(
                          enabled: !userManager.loading,
                          controller: _pass,
                          decoration: const InputDecoration(
                              labelText: 'Senha',
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              )),
                          autocorrect: false,
                          obscureText: true,
                          validator: (password) {
                            if (password!.isEmpty || password.length < 6) {
                              return 'Senha inválida';
                            } else {
                              return null;
                            }
                          },
                        ),
                      )),
                  Align(
                    alignment: Alignment.bottomRight,
                    // ignore: deprecated_member_use
                    child: FlatButton(
                      child: const Text('Esqueci minha senha'),
                      onPressed: () {},
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  SizedBox(
                    height: 44,
                    child: ElevatedButton(
                        onPressed: userManager.loading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  UserManager().signIn(
                                      user: Users(
                                          email: _email.text,
                                          password: _pass.text),
                                      onFail: (e) {
                                        alertErro(context, e);
                                      },
                                      onSuccess: () {
                                        pageController.animateToPage(1,
                                            duration: const Duration(
                                                milliseconds: 300),
                                            curve: Curves.easeOut);
                                      });
                                }
                              },
                        child: userManager.loading
                            ? CircularProgressIndicator()
                            : const Text(
                                "Entrar",
                                style: TextStyle(color: Colors.white),
                              ),
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                          onPrimary: Theme.of(context).primaryColor,
                        )),
                  ),
                  FlatButton(
                    onPressed: () {
                      pageController.jumpToPage(
                        2,
                      );
                    },
                    child: const Text('Não possui uma conta? Cadastre-se'),
                  )
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}

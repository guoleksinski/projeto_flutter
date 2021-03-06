// ignore_for_file: deprecated_member_use
import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:easy_mask/easy_mask.dart';
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
final TextEditingController _name = TextEditingController();
final TextEditingController _dateNasc = TextEditingController();
final TextEditingController _cpf = TextEditingController();

final Users user = Users(email: _email.text, password: _pass.text);
int selectedRadio = 0;

class Signup extends StatelessWidget {
  const Signup({Key? key}) : super(key: key);

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
                children: [
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
                              return 'E-mail inv??lido';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (email) => user.email = email!,
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Center(
                        child: TextFormField(
                          enabled: !userManager.loading,
                          controller: _name,
                          decoration: const InputDecoration(
                              labelText: 'Nome Completo',
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              )),
                          keyboardType: TextInputType.text,
                          autocorrect: false,
                          validator: (nome) {
                            if (nome!.isEmpty || nome.length < 20) {
                              return 'Nome inv??lido';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (name) => user.name = name,
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Center(
                        child: TextFormField(
                          enabled: !userManager.loading,
                          controller: _dateNasc,
                          decoration: const InputDecoration(
                              labelText: 'Data de nascimento',
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              )),
                          keyboardType: TextInputType.number,
                          autocorrect: false,
                          inputFormatters: [
                            TextInputMask(mask: '99/99/9999', reverse: false)
                          ],
                          validator: (data) {
                            if (data!.isEmpty || data.length < 10) {
                              return 'Data inv??lido';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (dataNsc) => user.data = dataNsc,
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Center(
                        child: TextFormField(
                          enabled: !userManager.loading,
                          controller: _cpf,
                          decoration: const InputDecoration(
                              labelText: 'CPF',
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              )),
                          keyboardType: TextInputType.number,
                          autocorrect: false,
                          inputFormatters: [
                            TextInputMask(
                                mask: '999.999.999-99',
                                placeholder: '_',
                                maxPlaceHolders: 11,
                                reverse: false)
                          ],
                          validator: (cpf) {
                            if (!CPFValidator.isValid(cpf)) {
                              return 'CPF inv??lido';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (cpf) => user.cpf = cpf,
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 20),
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
                              return 'Senha inv??lida';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (pass) => user.password = pass!,
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 20),
                      child: Center(
                        child: Row(children: [
                          ButtonBar(
                            alignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Radio(
                                value: 1,
                                groupValue: selectedRadio,
                                activeColor: Colors.green,
                                onChanged: (val) {
                                  selectedRadio = val as int;
                                },
                              ),
                              Radio(
                                value: 2,
                                groupValue: selectedRadio,
                                activeColor: Colors.green,
                                onChanged: (val) {
                                  selectedRadio = val as int;
                                },
                              ),
                              Radio(
                                value: 3,
                                groupValue: selectedRadio,
                                activeColor: Colors.green,
                                onChanged: (val) {
                                  selectedRadio = val as int;
                                },
                              ),
                            ],
                          )
                        ]),
                      )),
                  SizedBox(
                    height: 44,
                    child: ElevatedButton(
                        onPressed: userManager.loading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState?.save();
                                  UserManager().signUp(
                                      user: user,
                                      onFail: (e) {
                                        alertErro(context, e);
                                      },
                                      onSuccess: () {
                                        pageController.animateToPage(3,
                                            duration: const Duration(
                                                milliseconds: 300),
                                            curve: Curves.easeOut);
                                      });
                                }
                              },
                        child: userManager.loading
                            ? const CircularProgressIndicator()
                            : const Text(
                                "Cadastrar",
                                style: TextStyle(color: Colors.white),
                              ),
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                          onPrimary: Theme.of(context).primaryColor,
                        )),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: FlatButton(
                      child: const Text('Voltar para o login'),
                      onPressed: () {},
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}

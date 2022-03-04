import 'package:flutter/material.dart';
import 'package:help/screens_anjo/home_anjo.dart';
import 'package:help/screens_anjo_user/home_anjo_user.dart';
import 'package:help/screens_comuns/chamado_screen.dart';
import 'package:help/screens_comuns/login.dart';
import 'package:help/screens_comuns/signUp_screen.dart';
import 'package:help/screens_user/home_user.dart';

final PageController pageController = PageController(
  initialPage: 0,
  keepPage: true,
);

class BaseScreen extends StatelessWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: pageController,
      children: const [
        //paginas comuns entre todos os usuarios
        LoginScreen(), //0
        ChamadoScreen(), //1
        Signup(), //2
        //3

        // Fim das paginas comuns

        //paginas especificas para usuario
        HomeUser(), //4

        // Fim das paginas especificas para usuario

        //começo das paginas especificas para anjo
        HomeAnjo(), //5
        //fim das paginas especificas para anjo

        //começo das paginas especificas para usuario anjo
        HomeAnjoUser(), //6
        //fim das paginas especificas para usuario anjo
      ],
    );
  }
}

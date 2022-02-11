import 'package:flutter/material.dart';
import 'package:help/functions/chamado.dart';

class HomeAnjoUser extends StatelessWidget {
  const HomeAnjoUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        color: Colors.yellow,
        child: Center(
          child: ElevatedButton(
            onPressed: () => chamado(),
            child: const Text('Fazer Chamado'),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:help/functions/cancelar_chamado.dart';

class ChamadoScreen extends StatelessWidget {
  const ChamadoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        color: Colors.red,
        child: Center(
          child: ElevatedButton(
            onPressed: () => cancelarChamado(),
            child: const Text('Cancelar Chamado'),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Calculadora(),
      ),
    );
  }
}

class Calculadora extends StatelessWidget {
  const Calculadora({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Área do Display da Calculadora
        Expanded(
          flex: 2, // Ajusta a proporção da área de display para os botões
          child: Container(
            alignment: Alignment.bottomRight,
            padding: const EdgeInsets.all(20),
            child: const Text(
              "0",
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        // Área dos Botões da Calculadora
        Expanded(
          flex: 3, // Ajusta a proporção da área dos botões em relação ao display
          child: GridView.builder(
            itemCount: 16, // Total de botões
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, // Número de colunas
              childAspectRatio: 1.0, // Proporção dos itens
              crossAxisSpacing: 10, // Espaçamento horizontal
              mainAxisSpacing: 10, // Espaçamento vertical
            ),
            itemBuilder: (BuildContext context, int index) {
              // Aqui você pode definir a lógica para exibir os botões baseado no index
              // Por exemplo, usar um array de strings com os rótulos dos botões
              return botaoCalculadora((index + 1).toString(), () {
                // Lógica ao pressionar o botão
              });
            },
          ),
        ),
      ],
    );
  }

  Widget botaoCalculadora(String label, VoidCallback onPressed) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.all(24.0),
      ),
      onPressed: onPressed,
      child: Text(label, style: TextStyle(fontSize: 20)),
    );
  }
}

import 'package:flutter/material.dart';

import 'services/calculatorService.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Calculadora(),
      ),
    );
  }
}
class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CalculadoraState createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  String displayText = "0";
  String expression = "";
  final CalculatorService calculatorService = CalculatorService();

  void updateDisplay(String newText) {
    setState(() {
      if (newText == "C") {
        expression = "";
        displayText = "0";
      } else if (newText == "=") {
        double result = calculatorService.calculateResult(expression);
        displayText = result.toString();
        expression = result.toString();
      } else {
        expression += newText;
        displayText = expression;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Área do Display da Calculadora
        Expanded(
          flex: 2,
          child: Container(
            alignment: Alignment.bottomRight,
            padding: const EdgeInsets.all(20),
            // Usando displayText para mostrar o texto atualizado
            child: Text(
              displayText,
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const Divider(
          height: 4, // Espessura da linha
          color: Color.fromARGB(255, 114, 98, 98), // Cor da linha
        ),
        // Área dos Botões da Calculadora
        Expanded(
          flex: 3,
          child: GridView.builder(
            itemCount: buttonLabels.length, // Usando o tamanho do array de rótulos
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 1.0,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (BuildContext context, int index) {
              // Usando os rótulos definidos no array
              return botaoCalculadora(
                buttonLabels[index], () => updateDisplay(buttonLabels[index])
              );
            },
          ),
        ),
      ],
    );
  }

  Widget botaoCalculadora(String label, VoidCallback onPressed) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.all(24.0),
      ),
      onPressed: onPressed,
      child: Text(label, style: const TextStyle(fontSize: 20)),
    );
  }
}

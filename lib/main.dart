import 'package:flutter/material.dart';
import 'package:jl_calculator/services/calculator_logic.dart';

import 'services/calculator_service.dart';

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
  bool isResultShown = false;
  final calculatorLogic = CalculatorLogic();
  final calculatorService = Calculatorservice();

    final List<String> buttonLabels = [
    '1', '2', '3', '+',
    '4', '5', '6', '-',
    '7', '8', '9', 'X',
    'C', '0', '=', '/'
  ];

   void updateDisplay(String newText) {
    if (newText == "=") {
      final result = calculatorLogic.calculateResult(calculatorService);
      displayText = result.toString();
      isResultShown = true;
    } else {
      final updatedExpression = calculatorLogic.updateExpression(newText, isResultShown);
      displayText = updatedExpression;
      isResultShown = newText == "=";
    }
    setState(() {});
  }

 
  


@override
Widget build(BuildContext context) {
  return Scaffold(
    body: SafeArea(
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Área do Display da Calculadora
              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    displayText,
                    style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const Divider(
                height: 2, // Espessura da linha
                color: Colors.grey, // Cor da linha
              ),
              // Área dos Botões da Calculadora
              Expanded(
                flex: 3,
                child: GridView.builder(
                  itemCount: buttonLabels.length, // Atualizado para incluir todos os botões
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    // Configura o botão para chamar updateDisplay com o rótulo do botão
                    return botaoCalculadora(
                      buttonLabels[index], 
                      () => updateDisplay(buttonLabels[index])
                    );
                  },
                ),
              ),
            ],
          ),
          // Botão de histórico posicionado no canto superior esquerdo
          Positioned(
            top: 20,
            left: 20,
            child: FloatingActionButton(
            onPressed: () => calculatorLogic.showHistoryDialog(context),
            child: Icon(Icons.history),
            mini: true,
            ),
          ),
        ],
      ),
    ),
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

import 'package:flutter/material.dart';

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
  String expression = "";
  bool isResultShown = false; // Indica se o display está mostrando um resultado
  List<String> history = [];

  final Calculatorservice calculatorService = Calculatorservice();

  final List<String> buttonLabels = [
    '1', '2', '3', '+',
    '4', '5', '6', '-',
    '7', '8', '9', 'X',
    'C', '0', '=', '/'
  ];
 void showHistoryDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Histórico'),
          content: SingleChildScrollView(
            child: ListBody(
              children: history.map((e) => Text(e)).toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Fechar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

 void updateDisplay(String newText) {
  setState(() {
    if (newText == "C") {
      expression = "";
      displayText = "0";
      isResultShown = false;
    } else if (newText == "=") {
      // Guarda a expressão original antes de calcular o resultado
      final originalExpression = expression;

      // Calcula o resultado
      double result = calculatorService.calculateResult(expression);

      // Atualiza a exibição com o resultado
      displayText = result.toString();
      // Indica que o resultado está sendo exibido
      isResultShown = true;

      // Adiciona a expressão original e o resultado ao histórico
      history.add("$originalExpression = $displayText");

      // Prepara a expressão para a próxima operação, iniciando com o resultado atual
      expression = displayText;
    } else {
      if (isResultShown) {
        // Se um novo dígito é digitado logo após o resultado ser mostrado, começa uma nova expressão
        if ("+-X/".contains(newText)) {
          // Se um operador for digitado após o resultado, usa o resultado como início da nova expressão
          expression += newText;
        } else {
          // Se um dígito for digitado, começa uma nova expressão com esse dígito
          expression = newText;
        }
        isResultShown = false;
      } else {
        // Adiciona o novo texto à expressão atual
        expression += newText;
      }
      // Atualiza a exibição com a expressão atual
      displayText = expression;
    }
  });
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
              onPressed: showHistoryDialog,
              child: Icon(Icons.history),
              mini: true, // Torna o botão um pouco menor
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

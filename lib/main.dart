import 'package:flutter/material.dart';

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
  int i = 0;
  // Definindo os rótulos dos botões em um array para simplificar
  final List<String> buttonLabels = [
    '1', '2', '3', '+',
    '4', '5', '6', '-',
    '7', '8', '9', 'X',
    'C', '0', '=', '/'
  ];
  List<String> prompt = [];
   void updateDisplay(String newText) {
    setState(() {
      // Limpa a tela ou processa a operação
      if (newText == "C") {
        expression = "";
        displayText = "0";
      } else if (newText == "=") {
        // Calcula o resultado
        calculateResult();
      } else {
        // Adiciona o texto ao display e à expressão
        expression += newText;
        displayText = expression;
      }
    });
  }

  void calculateResult() {
  try {
    // Inicializa variáveis para armazenar o resultado atual e o operador atual
    double result = 0;
    String currentOperator = '';
    String currentNumber = '';

    for (int i = 0; i < expression.length; i++) {
      String char = expression[i];
      // Verifica se o caractere é um operador
      if (char == '+' || char == '-' || char == 'X' || char == '/') {
        // Calcula o resultado com o número atual e o operador atual
        if (currentNumber.isNotEmpty) {
          result = calculate(result, double.tryParse(currentNumber) ?? 0, currentOperator);
          currentNumber = ''; // Reseta o número atual para o próximo número
        }
        currentOperator = char; // Atualiza o operador atual
      } else {
        currentNumber += char; // Adiciona o caractere ao número atual
      }
    }

    // Garante que o último número seja calculado
    if (currentNumber.isNotEmpty) {
      result = calculate(result, double.tryParse(currentNumber) ?? 0, currentOperator);
    }

    // Atualiza o display e a expressão para o resultado
    displayText = result.toString();
    expression = result.toString();
  } catch (e) {
    displayText = "Erro";
    expression = "";
  }
}

// Função auxiliar para calcular o resultado com base no operador
double calculate(double result, double number, String operator) {
  switch (operator) {
    case '+':
      return result + number;
    case '-':
      return result - number;
    case 'X':
      return result * number;
    case '/':
      return result / number;
    default:
      return number; // Retorna o número se não houver operador
  }
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

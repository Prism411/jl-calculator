import 'package:flutter/material.dart';
import 'package:jl_calculator/services/calculator_service.dart';

class CalculatorLogic {
  String expression = "";
  List<String> history = [];

  // Método para adicionar texto à expressão e retornar a expressão atualizada
  String updateExpression(String newText, bool isResultShown) {
    if (newText == "C") {
      expression = "";
    } else if (newText == "=") {
      // Não faz nada aqui, o cálculo será tratado separadamente
    } else {
      if (isResultShown) {
        expression = newText;
      } else {
        expression += newText;
      }
    }
    return expression;
  }
    // Novo método para exibir o diálogo de histórico
  void showHistoryDialog(BuildContext context) {
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

  // Método para calcular o resultado baseado na expressão atual
  double calculateResult(Calculatorservice calculatorService) {
    final result = calculatorService.calculateResult(expression);
    // Adiciona a expressão e o resultado ao histórico
    history.add("$expression = $result");
    // Prepara a expressão para a próxima operação
    expression = result.toString();
    return result;
  }

  // Método para obter o histórico de operações
  List<String> getHistory() {
    return history;
  }

}

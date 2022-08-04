import 'package:flutter/material.dart';

enum Operator {
  add,
  subtract,
  multiply,
  divide,
  modulo,
}

extension OperatorExtension on Operator {
  String toOperatorString() {
    switch (this) {
      case Operator.add:
        return '+';
      case Operator.subtract:
        return '-';
      case Operator.multiply:
        return '*';
      case Operator.divide:
        return '/';
      case Operator.modulo:
        return '%';
    }
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _operand1 = 0.0;
  double _operand2 = 0.0;
  double _result = 0.0;
  Operator _operator = Operator.add;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalkulator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Operand 1',
                    ),
                    onChanged: (String value) {
                      setState(() {
                        _operand1 = double.tryParse(value) ?? 0;
                      });
                    },
                  ),
                ),
                DropdownButton<Operator>(
                  value: _operator,
                  onChanged: (Operator? value) {
                    setState(() {
                      _operator = value!;
                    });
                  },
                  items: Operator.values.map((Operator value) {
                    return DropdownMenuItem<Operator>(
                      value: value,
                      child: Text(value.toOperatorString()),
                    );
                  }).toList(),
                ),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Operand 2',
                    ),
                    onChanged: (String value) {
                      setState(() {
                        _operand2 = double.tryParse(value) ?? 0;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              child: const Text('Hitung'),
              onPressed: () {
                setState(() {
                  _result = _calculateResult();
                });
              },
            ),
            Text(
              '$_result',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
    );
  }

  double _calculateResult() {
    switch (_operator) {
      case Operator.add:
        return _operand1 + _operand2;
      case Operator.subtract:
        return _operand1 - _operand2;
      case Operator.multiply:
        return _operand1 * _operand2;
      case Operator.divide:
        return _operand1 / _operand2;
      case Operator.modulo:
        return _operand1 % _operand2;
    }
  }
}

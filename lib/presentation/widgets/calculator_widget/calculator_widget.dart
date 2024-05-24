import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final TextEditingController _textController = TextEditingController();
  String _displayText = '';

  void _updateText(String text) {
    setState(() {
      _displayText = text;
    });
  }

  void _onPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _displayText = '';
      } else if (buttonText == '=') {
        try {
          Parser p = Parser();
          Expression exp = p.parse(_displayText);
          ContextModel cm = ContextModel();
          double result = exp.evaluate(EvaluationType.REAL, cm);
          _displayText = result.toString();
        } catch (e) {
          print('Error: $e');
          // Handle error in evaluation
          _displayText = 'Error';
        }
      } else {
        _displayText += buttonText;
      }
      _textController.text = _displayText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                // labelText: 'Enter expression',
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _displayText = '';
                        _textController.clear();
                      });
                    },
                    icon: const Icon(
                      Icons.backspace,
                      size: 30,
                    )),
                border: OutlineInputBorder(),
              ),
              onChanged: _updateText,
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 20),
            CalculatorGrid(onPressed: _onPressed),
          ],
        ),
      ),
    );
  }
}
class CalculatorGrid extends StatelessWidget {
  final Function(String) onPressed;

  CalculatorGrid({required this.onPressed});

  Widget _buildButton(String text) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: ElevatedButton(
          onPressed: () => onPressed(text),
          child: Text(
            text,
            style: TextStyle(fontSize: 24.0),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            _buildButton('+'),
            _buildButton('7'),
            _buildButton('8'),
            _buildButton('9'),
          ],
        ),
        Row(
          children: [
            _buildButton('-'),
            _buildButton('4'),
            _buildButton('5'),
            _buildButton('6'),
          ],
        ),
        Row(
          children: [
            _buildButton('\u00D7'),
            _buildButton('1'),
            _buildButton('2'),
            _buildButton('3'),
          ],
        ),
        Row(
          children: [
            _buildButton('\u00F7'),
            _buildButton('0'),
            _buildButton('.'),
            _buildButton('='),
          ],
        ),
      ],
    );
  }
}

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
        title: const Text('Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
                border: const OutlineInputBorder(),
              ),
              onChanged: _updateText,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 20),
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

  Widget _buildButton(String text, double elevation, Color buttonColor) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            elevation: elevation,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3))
          ),
          onPressed: () => onPressed(text),
          child: Text(
            text,
            style: const TextStyle(fontSize: 24.0,color: Colors.black),
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
            _buildButton('+',0,const Color(0xffE6D6FD)),
            _buildButton('7',0,Colors.transparent),
            _buildButton('8',0,Colors.transparent),
            _buildButton('9',0,Colors.transparent),
          ],
        ),
        Row(
          children: [
            _buildButton('-',0,const Color(0xffE6D6FD)),
            _buildButton('4',0,Colors.transparent),
            _buildButton('5',0,Colors.transparent),
            _buildButton('6',0,Colors.transparent),
          ],
        ),
        Row(
          children: [
            _buildButton('\u00D7',0,const Color(0xffE6D6FD)),
            _buildButton('1',0,Colors.transparent),
            _buildButton('2',0,Colors.transparent),
            _buildButton('3',0,Colors.transparent),
          ],
        ),
        Row(
          children: [
            _buildButton('\u00F7',0,const Color(0xffE6D6FD)),
            _buildButton('0',0,Colors.transparent),
            _buildButton('.',0,Colors.transparent),
            _buildButton('=',0,const Color(0xffE6D6FD)),
          ],
        ),
      ],
    );
  }
}

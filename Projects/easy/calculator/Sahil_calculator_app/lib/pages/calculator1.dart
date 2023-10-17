// ignore_for_file: prefer_interpolation_to_compose_strings, curly_braces_in_flow_control_structures, library_private_types_in_public_api

import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {


  Widget myButton(String btnTxt, Color btnColor, Color txtColor) {
    return MaterialButton(
      onPressed: () {
        calculate(btnTxt);
      },
      padding: const EdgeInsets.all(15),
      color: btnColor,
      shape: const CircleBorder(),
      child: Text(
        btnTxt,
        style: TextStyle(
          color: txtColor,
          fontSize: 35,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text('Calculator', style: TextStyle(color: Colors.black),),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          // Calculator display
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children:[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Wrap(
                    children: [
                      Text(
                        '$text',
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          overflow: TextOverflow.clip,
                          color: Colors.black87,
                          fontSize: 70,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              myButton('AC', Colors.grey, Colors.black),
              myButton('+/-', Colors.grey, Colors.black),
              myButton('%', Colors.grey, Colors.black),
              myButton('/', Colors.grey, Colors.black),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              myButton('7', Colors.grey.shade700, Colors.black),
              myButton('8', Colors.grey.shade700, Colors.black),
              myButton('9', Colors.grey.shade700, Colors.black),
              myButton('x', Colors.grey, Colors.black),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              myButton('4', Colors.grey.shade700, Colors.black),
              myButton('5', Colors.grey.shade700, Colors.black),
              myButton('6', Colors.grey.shade700, Colors.black),
              myButton('-', Colors.grey, Colors.black),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              myButton('1', Colors.grey.shade700, Colors.black),
              myButton('2', Colors.grey.shade700, Colors.black),
              myButton('3', Colors.grey.shade700, Colors.black),
              myButton('+', Colors.grey, Colors.black),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              //this is button Zero
              MaterialButton(
                padding: const EdgeInsets.fromLTRB(34, 20, 128, 20),
                onPressed: () {
                  calculate('0');
                },
                shape: const StadiumBorder(),
                color: Colors.grey.shade700,
                child: const Text(
                  '0',
                  style: TextStyle(fontSize: 35, color: Colors.black),
                ),
              ),
              myButton('.', Colors.grey.shade700, Colors.black),
              myButton('=', Colors.grey, Colors.black),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  dynamic text = '0';
  double num1 = 0;
  double num2 = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic oper = '';
  dynamic preOper = '';

  void calculate(btnText) {
    if (btnText == 'AC') {
      text = '0';
      num1 = 0;
      num2 = 0;
      result = '';
      finalResult = '0';
      oper = '';
      preOper = '';
    } else if (oper == '=' && btnText == '=') {
      if (preOper == '+') {
        finalResult = add();
      } else if (preOper == '-') {
        finalResult = sub();
      } else if (preOper == 'x') {
        finalResult = mul();
      } else if (preOper == '/') {
        finalResult = div();
      }
    } else if (btnText == '+' ||
        btnText == '-' ||
        btnText == 'x' ||
        btnText == '/' ||
        btnText == '=') {
      if (num1 == 0) {
        num1 = double.parse(result);
      } else {
        num2 = double.parse(result);
      }

      if (oper == '+') {
        finalResult = add();
      } else if (oper == '-') {
        finalResult = sub();
      } else if (oper == 'x') {
        finalResult = mul();
      } else if (oper == '/') {
        finalResult = div();
      }
      preOper = oper;
      oper = btnText;
      result = '';
    } else if (btnText == '%') {
      result = num1 / 100;
      finalResult = doesContainDecimal(result);
    } else if (btnText == '.') {
      if (!result.toString().contains('.')) {
        result = result.toString() + '.';
      }
      finalResult = result;
    } else if (btnText == '+/-') {
      result.toString().startsWith('-')
          ? result = result.toString().substring(1)
          : result = '-' + result.toString();
      finalResult = result;
    } else {
      result = result + btnText;
      finalResult = result;
    }

    setState(() {
      text = finalResult;
    });
  }

  String add() {
    result = (num1 + num2).toString();
    num1 = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (num1 - num2).toString();
    num1 = double.parse(result);
    return doesContainDecimal(result);
  }

  String mul() {
    result = (num1 * num2).toString();
    num1 = double.parse(result);
    return doesContainDecimal(result);
  }

  String div() {
    result = (num1 / num2).toString();
    num1 = double.parse(result);
    return doesContainDecimal(result);
  }

  String doesContainDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }
}

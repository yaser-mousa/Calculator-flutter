import 'package:flutter/material.dart';
import 'package:calculator/list_buttons_data.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  TextEditingController _Numbercontroller;

  void initState() {
    // TODO: implement initState
    super.initState();
    // _Numbercontroller = TextEditingController();
  }

  String txtNumb = "0";
  double numOne = 0.0;
  double numTwo = 0.0;
  String result = '';
  String ope = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Container(
        color: Colors.black,
        child: drawCalcBody(),
      ),
    );
  }

  Widget drawCalcBody() {
    var buttonsDataLists = buttonsDataList;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        drawTextNumbers(),
        drawButtonsRow(buttonsDataLists[0]),
        drawButtonsRow(buttonsDataLists[1]),
        drawButtonsRow(buttonsDataLists[2]),
        drawButtonsRow(buttonsDataLists[3]),
        drawButtonsRow(buttonsDataLists[4]),
      ],
    );
  }

  Widget drawTextNumbers() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Text(
              txtNumb,
              style: TextStyle(color: Colors.white, fontSize: 60),
              maxLines: 1,
              textAlign: TextAlign.right,
            ),
          ),
        ),
      ],
    );
  }

  Widget drawButtonsRow(var btnDataList) {
    var names = btnDataList[0];
    if (names.length > 3) {
      return Row(
        children: [
          drawButton(btnDataList[0][0], btnDataList[1][0], btnDataList[2][0]),
          drawButton(btnDataList[0][1], btnDataList[1][1], btnDataList[2][1]),
          drawButton(btnDataList[0][2], btnDataList[1][2], btnDataList[2][2]),
          drawButton(btnDataList[0][3], btnDataList[1][3], btnDataList[2][3])
        ],
      );
    } else {
      return Row(
        children: [
          drawButton(btnDataList[0][0], btnDataList[1][0], btnDataList[2][0]),
          drawButton(btnDataList[0][1], btnDataList[1][1], btnDataList[2][1]),
          drawButton(btnDataList[0][2], btnDataList[1][2], btnDataList[2][2]),
        ],
      );
    }
  }

  Widget drawButton(String buttonName, Color buttonColor, int choice) {
    var myShape;

    var txtColor = Colors.white;

    if (buttonColor == Colors.grey) {
      txtColor = Colors.black;
    }

    if (buttonName != '0') {
      return Expanded(
        child: Container(
          height: 90,
          padding: EdgeInsets.only(bottom: 10, right: 10),
          child: RaisedButton(
            onPressed: () {
              setState(() {
                runCalc(choice, buttonName);
              });
            },
            child: Text(
              buttonName,
              style: TextStyle(fontSize: 30, color: txtColor),
            ),
            shape: CircleBorder(),
            color: buttonColor,
          ),
        ),
      );
    } else {
      return drawZeroButton(buttonName);
    }
  }

  Widget drawZeroButton(String buttonName) {
    return Container(
      height: 80,
      width: 190,
      padding: EdgeInsets.only(bottom: 10, right: 10),
      child: RaisedButton(
        onPressed: () {
          setState(() {
            if (txtNumb == '0') {
              txtNumb = buttonName;
            } else {
              txtNumb = txtNumb + buttonName;
            }
          });
        },
        child: Text(
          buttonName,
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(100.0)),
        color: Colors.grey.shade800,
      ),
    );
  }

  void runCalc(int choice, String buttonName) {
    if (choice == 0) {
      typeNumbers(buttonName);
    } else {
      makeOperation(buttonName);
    }
  }

  void typeNumbers(String numberName) {
    if (txtNumb == '0') {
      txtNumb = numberName;
    } else {
      txtNumb = txtNumb + numberName;
    }
  }

  void makeOperation(String buttonName) {
    switch (buttonName) {
      case 'AC':
        restartApp();
        break;

      case '+/-':
        makeMinus();

        break;

      case '%':
        txtNumb = (double.parse(txtNumb) / 100).toString();
        break;

      case '÷':
        stepOne('÷');
        break;

      case '×':
        stepOne('×');
        break;

      case '-':
        stepOne('-');
        break;

      case '+':
        stepOne('+');
        break;

      case '=':
        stepTow();
        break;
    }
  }

  void restartApp() {
    txtNumb = "0";
    numOne = 0.0;
    numTwo = 0.0;
    result = '';
    ope = '';
  }

  void makeMinus() {
    if (double.parse(txtNumb) > 0) {
      txtNumb = '-' + txtNumb;
    } else {
      double abs = double.parse(txtNumb);
      txtNumb = (abs.abs()).toString();
    }
  }

  void stepOne(String ope) {
    numOne = double.parse(txtNumb);
    txtNumb = '0';
    this.ope = ope;
  }

  void stepTow() {
    numTwo = double.parse(txtNumb);

    switch (ope) {
      case '÷':
        txtNumb = (numOne / numTwo).toString();
        break;

      case '×':
        txtNumb = (numOne * numTwo).toString();
        break;

      case '-':
        txtNumb = (numOne - numTwo).toString();
        break;

      case '+':
        txtNumb = (numOne + numTwo).toString();
        break;
    }

    txtNumb = dicRemove(txtNumb);
  }

  String dicRemove(String txtnumb) {
    if (txtnumb.contains('.')) {
      List<String> _split = txtnumb.split('.');
      if (_split[1] == '0') {
        txtnumb = _split[0];
        return txtnumb;
      }

      return txtnumb;
    }
  }
}

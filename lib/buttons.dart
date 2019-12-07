import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var test;
  static var userQuestion = '';
  var answer; //used to compute
  var displayAnswer = ''; //display final answer
  var colourTheme = Colors.deepPurple;
  static List<String> finalElements;
  static var editQuestion = '';

  void _buttonEqual() {
    answer = 0;

    editQuestion = userQuestion;

    for (var i = 0; i < editQuestion.length - 2; i++) {                         //check for Double Negation
      if (editQuestion[i] == '-' && editQuestion[i + 1] == '-') {               // 1--2 -> 1+2
        editQuestion = editQuestion.substring(0, i) +
            '+' +
            editQuestion.substring(i + 2, editQuestion.length);
      }
    }

    for (var i = 1; i < editQuestion.length; i++) {                             //check for double plus
      if (editQuestion[i] == '+' && editQuestion[i - 1] == '+') {               // 1+++2 -> 1+0+0+0+2
        editQuestion = editQuestion.substring(0, i) +
            '0' +
            editQuestion.substring(i, editQuestion.length);
      }
    }

    // +9 becomes 0+9
    if (editQuestion[0] == '+') {
      editQuestion = '0' + editQuestion;
    }

    //if the question starts with a number, add +0, this just helps with the addition functions
    if (startsWithNumber(editQuestion)) {
      editQuestion = '0+' + editQuestion;
    }

    //check if there's a '-' sign, execute subtraction
    for (var i = 0; i < editQuestion.length; i++) {
      if (editQuestion[i] == '-') {
        setState(() {
          _operateSubtraction();
        });
        break;
      }
    }

    //break up numbers separated by +
    finalElements = editQuestion.split("+");

    //this helps with multiplicativeOperation that uses split(x), there needs to be an x
    for ( var i = 0 ; i < finalElements.length ; i++ ) {
      if ( finalElements[i].contains('/') ) {
        finalElements[i] = "1×" + finalElements[i];
      }
    }

    //if theres a x symbol, execute multiplication
    for (var i = 0; i < finalElements.length; i++) {
      if (finalElements[i].contains('×')) {
        setState(() {
          _operateMultiplication();
        });
        break;
      }
    }

    //if there exists a '+' sign, execute addition
    for (var i = 0; i < editQuestion.length; i++) {
      if (editQuestion[i] == '+') {
        setState(() {
          _operateAddition();
        });
        break;
      }
    }

    displayAnswer = answer.toString();

    if ( displayAnswer.endsWith('.0') ) {
      displayAnswer = displayAnswer.substring(0,displayAnswer.length-2);
    }


  }

  void _operateAddition() {
    for (var i = 0; i < finalElements.length; i++) {
      answer = answer + double.parse(finalElements[i]);
    }
  }

  //place a plus symbol infront of negative sign only if it doesn't have a sign before it
  void _operateSubtraction() {
    for (var i = 1; i < editQuestion.length; i++) {
      if (editQuestion[i] == '-' && !isOperator(editQuestion[i - 1])) {
        editQuestion = editQuestion.substring(0, i) +
            '+' +
            editQuestion.substring(i, editQuestion.length);
        i = i + 2;
      }
    }
  }

  static String _operateDivision(String abc) {
    double dividedResult;

    List<String> divisiveElements = abc.split("/");
    dividedResult =
        double.parse(divisiveElements[0]) / double.parse(divisiveElements[1]);

    if (divisiveElements.length > 2) {
      for (var k = 2; k < divisiveElements.length; k++) {
        dividedResult = dividedResult / double.parse(divisiveElements[k]);
      }
    }

    return dividedResult.toString();
  }

  void _operateMultiplication() {
    double multipliedResult;

    for (var i = 0; i < finalElements.length; i++) {
      if (finalElements[i].contains("×")) {
        List<String> multiplicativeElements = finalElements[i].split("×");

        //compute division first, then multiplication
        for (var k = 0; k < multiplicativeElements.length; k++) {
          if (multiplicativeElements[k].contains('/')) {
            multiplicativeElements[k] =
                _operateDivision(multiplicativeElements[k]);
          }
        }

        multipliedResult = double.parse(multiplicativeElements[0]) *
            double.parse(multiplicativeElements[1]);

        if (multiplicativeElements.length > 2) {
          for (var k = 2; k < multiplicativeElements.length; k++) {
            multipliedResult =
                multipliedResult * double.parse(multiplicativeElements[k]);
          }
        }

        finalElements[i] = multipliedResult.toString();
      }
    }
  }

  bool isOperator(String abc) {
    var x = abc[0];

    if (x == '+' || x == '-' || x == '×' || x == '/') {
      return true;
    }

    return false;
  }

  bool startsWithNumber(String abc) {
    var x = abc[0];

    if (x == '0' ||
        x == '1' ||
        x == '2' ||
        x == '3' ||
        x == '4' ||
        x == '5' ||
        x == '6' ||
        x == '7' ||
        x == '8' ||
        x == '9') {
      return true;
    }

    return false;
  }

  void _buttonPercent() {
    setState(() {
      if (displayAnswer.toString() != '') {
        _buttonClr();
      }
      userQuestion = userQuestion + '%';
    });
  }


  void _buttonDel() {
    if (  userQuestion.length == 0 ) {
    }
    else {
      setState(() {
        userQuestion = userQuestion.substring(0,userQuestion.length-1);
      });
    }
  }

  void _buttonClr() {
    setState(() {
      userQuestion = '';
      displayAnswer = '';
    });
  }

  void _button7() {
    setState(() {
      if (displayAnswer.toString() != '') {
        _buttonClr();
      }
      userQuestion = userQuestion + '7';
    });
  }

  void _button8() {
    setState(() {
      if (displayAnswer.toString() != '') {
        _buttonClr();
      }
      userQuestion = userQuestion + '8';
    });
  }

  void _button9() {
    setState(() {
      if (displayAnswer.toString() != '') {
        _buttonClr();
      }
      userQuestion = userQuestion + '9';
    });
  }

  void _button6() {
    setState(() {
      if (displayAnswer.toString() != '') {
        _buttonClr();
      }
      userQuestion = userQuestion + '6';
    });
  }

  void _button5() {
    setState(() {
      if (displayAnswer.toString() != '') {
        _buttonClr();
      }
      userQuestion = userQuestion + '5';
    });
  }

  void _button4() {
    setState(() {
      if (displayAnswer.toString() != '') {
        _buttonClr();
      }
      userQuestion = userQuestion + '4';
    });
  }

  void _button3() {
    setState(() {
      if (displayAnswer.toString() != '') {
        _buttonClr();
      }
      userQuestion = userQuestion + '3';
    });
  }

  void _button2() {
    setState(() {
      if (displayAnswer.toString() != '') {
        _buttonClr();
      }
      userQuestion = userQuestion + '2';
    });
  }

  void _button1() {
    setState(() {
      if (displayAnswer.toString() != '') {
        _buttonClr();
      }
      userQuestion = userQuestion + '1';
    });
  }

  void _button0() {
    setState(() {
      if (displayAnswer.toString() != '') {
        _buttonClr();
      }
      userQuestion = userQuestion + '0';
    });
  }

  void _buttonDecimal() {
    setState(() {
      if (displayAnswer.toString() != '') {
        _buttonClr();
      }
      userQuestion = userQuestion + '.';
    });
  }

  void _buttonDivide() {
    setState(() {
      if (displayAnswer.toString() != '') {
        _buttonClr();
      }
      userQuestion = userQuestion + '/';
    });
  }

  void _buttonMultiply() {
    setState(() {
      if (displayAnswer.toString() != '') {
        _buttonClr();
        userQuestion = 'Ans' + '×';
      } else {
        userQuestion = userQuestion + '×';
      }
    });
  }

  void _buttonSubtract() {
    setState(() {
      if (displayAnswer.toString() != '') {
        _buttonClr();
        userQuestion = 'Ans' + '-';
      } else {
        userQuestion = userQuestion + '-';
      }
    });
  }

  void _buttonAddition() {
    setState(() {
      if (displayAnswer.toString() != '') {
        _buttonClr();
        userQuestion = 'Ans' + '+';
      } else {
        userQuestion = userQuestion + '+';
      }
    });
  }

  void _buttonAns() {
    setState(() {
      if (displayAnswer.toString() != '') {
        _buttonClr();
      }
      userQuestion = userQuestion + 'Ans';
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: colourTheme[100],
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 25,
                ),
              )
            ],
          ),
          Expanded(
            flex: 3,
            child: Container(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Text(
                  userQuestion,
                  style: TextStyle(fontSize: 50, color: colourTheme),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(right: 20),
              alignment: Alignment.bottomRight,
              child: Text(
                displayAnswer.toString(),
                style: TextStyle(fontSize: 50, color: colourTheme),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 4, right: 4),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: _buttonDel,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            color: Colors.red[400],
                            child: Center(
                              child: Text(
                                'DEL',
                                style: TextStyle(
                                    fontSize: 25, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: _buttonClr,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            color: Colors.green[400],
                            child: Center(
                              child: Text(
                                'C',
                                style: TextStyle(
                                    fontSize: 25, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: _buttonPercent,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            color: colourTheme[400],
                            child: Center(
                              child: Text(
                                '%',
                                style: TextStyle(
                                    fontSize: 25, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: _buttonDivide,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            color: colourTheme[400],
                            child: Center(
                              child: Text(
                                '÷',
                                style: TextStyle(
                                    fontSize: 40, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 4, right: 4),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: _button7,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            color: colourTheme[50],
                            child: Center(
                              child: Text(
                                '7',
                                style: TextStyle(
                                    fontSize: 30, color: colourTheme),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: _button8,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            color: colourTheme[50],
                            child: Center(
                              child: Text(
                                '8',
                                style: TextStyle(
                                    fontSize: 30, color: colourTheme),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: _button9,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            color: colourTheme[50],
                            child: Center(
                              child: Text(
                                '9',
                                style: TextStyle(
                                    fontSize: 30, color: colourTheme),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: _buttonMultiply,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            color: colourTheme[400],
                            child: Center(
                              child: Text(
                                '×',
                                style: TextStyle(
                                    fontSize: 40, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 4, right: 4),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: _button4,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            color: colourTheme[50],
                            child: Center(
                              child: Text(
                                '4',
                                style: TextStyle(
                                    fontSize: 30, color: colourTheme),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: _button5,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            color: colourTheme[50],
                            child: Center(
                              child: Text(
                                '5',
                                style: TextStyle(
                                    fontSize: 30, color: colourTheme),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: _button6,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            color: colourTheme[50],
                            child: Center(
                              child: Text(
                                '6',
                                style: TextStyle(
                                    fontSize: 30, color: colourTheme),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: _buttonSubtract,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            color: colourTheme[400],
                            child: Center(
                              child: Text(
                                '-',
                                style: TextStyle(
                                    fontSize: 40, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 4, right: 4),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: _button1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            color: colourTheme[50],
                            child: Center(
                              child: Text(
                                '1',
                                style: TextStyle(
                                    fontSize: 30, color: colourTheme),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: _button2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            color: colourTheme[50],
                            child: Center(
                              child: Text(
                                '2',
                                style: TextStyle(
                                    fontSize: 30, color: colourTheme),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: _button3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            color: colourTheme[50],
                            child: Center(
                              child: Text(
                                '3',
                                style: TextStyle(
                                    fontSize: 30, color: colourTheme),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: _buttonAddition,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            color: colourTheme[400],
                            child: Center(
                              child: Text(
                                '+',
                                style: TextStyle(
                                    fontSize: 40, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 4, right: 4),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: _button0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            color: colourTheme[50],
                            child: Center(
                              child: Text(
                                '0',
                                style: TextStyle(
                                    fontSize: 30, color: colourTheme),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: _buttonDecimal,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            color: colourTheme[50],
                            child: Center(
                              child: Text(
                                '.',
                                style: TextStyle(
                                    fontSize: 30, color: colourTheme),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: _buttonAns,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            color: colourTheme[50],
                            child: Center(
                              child: Text(
                                'ANS',
                                style: TextStyle(
                                    fontSize: 25, color: colourTheme),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: _buttonEqual,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            color: colourTheme[400],
                            child: Center(
                              child: Text(
                                '=',
                                style: TextStyle(
                                    fontSize: 40, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Container(
                  height: 15,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

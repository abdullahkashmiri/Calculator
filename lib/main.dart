import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  dynamic text = '0';
  Widget calcbutton(String btntxt, Color btncolor, Color txtcolor) {
    return Container(
      child: ElevatedButton(
        onPressed: (){
          //TODO: add function for button press
          calculation(btntxt);
        },
        child: Text('$btntxt',
          style: TextStyle(
            fontSize: 30,
            color: txtcolor,
          ),
        ),
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          primary: btncolor,
          padding: EdgeInsets.all(20),
          minimumSize: Size(90,90),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Calculator'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // calculator display
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(padding: const EdgeInsets.all(10.0),
                      child:Text('$text',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 100,
                      ),
                      ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcbutton('AC',Colors.grey[300]!,Colors.black),
                calcbutton('+/-',Colors.grey[300]!,Colors.black),
                calcbutton('%',Colors.grey[300]!,Colors.black),
                calcbutton('/',Colors.amber[700]!,Colors.white),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcbutton('7',Colors.grey[850]!,Colors.black),
                calcbutton('8',Colors.grey[850]!,Colors.black),
                calcbutton('9',Colors.grey[850]!,Colors.black),
                calcbutton('x',Colors.amber[700]!,Colors.white),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcbutton('4',Colors.grey[850]!,Colors.black),
                calcbutton('5',Colors.grey[850]!,Colors.black),
                calcbutton('6',Colors.grey[850]!,Colors.black),
                calcbutton('-',Colors.amber[700]!,Colors.white),
              ],
            ),   SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcbutton('3',Colors.grey[850]!,Colors.black),
                calcbutton('2',Colors.grey[850]!,Colors.black),
                calcbutton('1',Colors.grey[850]!,Colors.black),
                calcbutton('+',Colors.amber[700]!,Colors.white),
              ],
            ),
            SizedBox(height: 10,),
// last row with 0 button
      Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
      ElevatedButton(
        onPressed: () {
          // button function
        },
        style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
       //   padding: EdgeInsets.fromLTRB(34, 28, 128, 20),
          minimumSize: Size(180, 90),
          primary: Colors.grey[900]!,
        ),
        child: Center(
          child: Text(
            '0',
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
            ),
            textAlign: TextAlign.center, // center the text horizontally
          ),
        ),
      ),
    calcbutton('.',Colors.grey[850]!,Colors.white),
    calcbutton('=',Colors.amber[700]!,Colors.white),
  ],
),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
  // Calculator Logic
//dynamic text = '0';
double numOne = 0;
double numTwo = 0;

dynamic result = '';
dynamic finalResult = '';
dynamic operator = '';
dynamic preOperator = '';

void calculation(btnText) {

  if (btnText == 'AC') {
    text = '0';
    numOne = 0;
    numTwo = 0;
    result = 0;
    finalResult = 0;
    operator = '';
    preOperator = '';

  } else if (operator == '=' && btnText == '=') {

    if (preOperator == '+') {
      finalResult = add();
    } else if (preOperator == '-') {
      finalResult = sub();
    } else if (preOperator == 'x') {
      finalResult = mul();
    } else if (preOperator == '/') {
      finalResult = div();
    }

  }else if(btnText == '+' || btnText == '-' || btnText == 'x' || btnText == '/' || btnText == '='){

    if(numOne == 0){
      numOne = double.parse(result);
    }else{
      numTwo = double.parse(result);
    }

    if (operator == '+') {
      finalResult = add();
    } else if (operator == '-') {
      finalResult = sub();
    } else if (operator == 'x') {
      finalResult = mul();
    } else if (operator == '/') {
      finalResult = div();
    }
    preOperator = operator;
    operator = btnText;
    result = '';
  }else if(btnText == '%'){
    result = numOne / 100;
    finalResult = doesContainDecimal(result);
  }else if(btnText == '.'){
    if(!result.toString().contains('.')){
      result = result.toString() + '.';
    }
    finalResult = result;

  }else if(btnText == '+/-'){

    result.toString().startsWith('-') ? result = result.toString().substring(1): result = '-' + result.toString();
    finalResult = result;
  }else{
    result = result + btnText;
    finalResult = result;
  }
  setState(() {
    text = finalResult;
  });
}

String add(){
  result = (numOne+numTwo).toString();
  numOne = double.parse(result);
  return doesContainDecimal(result);
}
  String sub(){
    result = (numOne-numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }
  String div(){
    result = (numOne/numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }
  String mul(){
    result = (numOne*numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }
  String doesContainDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0)) {
        return result = splitDecimal[0].toString();
      }
    }
    return result;
  }
}
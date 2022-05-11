import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),

      home: Scaffold(
        appBar: AppBar(
          title: Text('Unit Converter'),
        ),
        body: MyHomePage(),

      ),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<String> _mesaurementScale = [
    'Meters',
    'Kilometers',
    'Grams',
    'Kilograms',
    'Feet',
    'Miles',
    'Pounds',
    'Ounces'
  ];

  double convertableValue=0;
  String fromScale="Meters";
  String toScale="Meters";
  String result="hello";

  final TextStyle labelStyle= TextStyle(
    fontSize: 16,
  );

  final TextStyle resultStyle= TextStyle(
    fontSize: 16,
    color: Colors.teal,
    fontWeight: FontWeight.w400,

  );

  final Map<String,int> _messureMap= {
    'Meters': 0,
    'Kilometers': 1,
    'Grams': 2,
    'Kilograms': 3,
    'Feet': 4,
    'Miles': 5,
    'Pounds': 6,
    'Ounces': 7,
  };

  dynamic _formulas = {
    '0': [1, 0.001, 0, 0, 3.28084, 0.000621371, 0, 0],
    '1': [1000, 1, 0, 0, 3280.84, 0.621371, 0, 0],
    '2': [0, 0, 1, 0.0001, 0, 0, 0.00220462, 0.035274],
    '3': [0, 0, 1000, 1, 0, 0, 2.20462, 35.274],
    '4': [0.3048, 0.0003048, 0, 0, 1, 0.000189394, 0, 0],
    '5': [1609.34, 1.60934, 0, 0, 5280, 1, 0, 0],
    '6': [0, 0, 453.592, 0.453592, 0, 0, 1, 16],
    '7': [0, 0, 28.3495, 0.0283495, 3.28084, 0, 0.0625, 1],
  };

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Padding(padding: EdgeInsets.all(15),
        child: Column(
          children: [
           TextField(
             decoration: InputDecoration(
               label: Text(
                 'Input convertable value',
                 style: labelStyle,
               ),
             ),

             onChanged: (value){
               convertableValue= double.parse(value);
             },

           ),
            SizedBox(height: 25,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("From"),
                    DropdownButton(items: _mesaurementScale.map((String value) => DropdownMenuItem<String>(child:
                    Text(value),
                      value: value,
                    )).toList(), onChanged: (value){
                     setState(() {
                       fromScale= value.toString();
                     });
                    },
                      value: fromScale,
                    )
  
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("To"),
                    DropdownButton(items: _mesaurementScale.map((String value) => DropdownMenuItem<String>(child:
                    Text(value),
                      value: value,
                    )).toList(),

                      onChanged: (value) {
                        setState(() {
                          toScale = value.toString();
                        });
                      },
                      value: toScale,


                    )

                  ],
                ),
              ],
            ),

            MaterialButton(
              minWidth: double.infinity,
              color: Colors.green,
              onPressed: _converter,
              child: Text(
                'Convert',
                style: TextStyle(color: Colors.white),
              ),


            ),
            SizedBox(height: 25.0),
            Text(
             result,
              style: resultStyle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        
      ),

    );

  }

  void _converter()
  {
    if (convertableValue!=0 && toScale.isNotEmpty && fromScale.isNotEmpty) {
      int? toScaleValue= _messureMap[toScale];
      int? fromScaleValue= _messureMap[fromScale];



      var multiplier= _formulas[fromScaleValue.toString()][toScaleValue];

      if (multiplier==0) {
        setState(() {
          result = "It's not possible.";
        });
      }else{

      setState(() {
        result= "$convertableValue $fromScale = ${convertableValue * multiplier} $toScale";
      });

    }}
      else{
      setState(() {
        result = "Please enter a non zero value";
      });
    }

  }
}

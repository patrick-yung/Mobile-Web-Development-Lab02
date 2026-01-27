import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(myApp());
}

class myApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Calculator();
  }
}

class Calculator extends State<myApp> {
  double totalIncome = 0;
  double overtimeIncome = 0;
  double regularIncome = 0;
  double incomeTax = 0;
  String status = "";

  TextEditingController hourWorked = TextEditingController();
  TextEditingController hourRate = TextEditingController();
  
  void totalPay(double hours, double rate) {
    if(hours <= 40){
      totalIncome =  hours * rate;
    }else {
      totalIncome = (hours-40)*rate*1.5 + 40*rate;
    }
  }
  void regularPay(double hours, double rate) {
    if(hours <= 40){
      regularIncome =  hours * rate;
    }else {
      regularIncome = 40*rate;
    }
  }

  void overtimePay(double hours, double rate) {
    if(hours <= 40){
      overtimeIncome = 0;
    }else {
      overtimeIncome = (hours-40)*rate*1.5;
    }
  }

  void tax(double payment) {
    incomeTax = payment * 0.18;
  }

  void CalculatorFunction() {
    double hours = double.parse(hourWorked.text);
    double rate = double.parse(hourRate.text);
    if(hours < 0 || rate < 0) {
      setState(() {
        status = "Invalid Hours or Rate Entered";
      });
      return;
    }

    setState(() {
      status = "";
      totalPay(hours, rate);
      regularPay(hours, rate);
      overtimePay(hours, rate);
      tax(totalIncome);
    });

  }
  


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Income Calculator'),
        ),
        body: Center(
          child: Column(
            children : [ 

              TextField(
                controller: hourWorked,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Number of Hours Worked',
                ),
              ),
              TextField(
                controller: hourRate,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Hour Rate',
                ),
              ),

              ElevatedButton(
                onPressed: CalculatorFunction,
                child: const Text('Calculate'),
              ),
              if (status.isNotEmpty) 
                Text(status),

              Text("Total Income: \$${totalIncome.toStringAsFixed(2)}"),
              Text("Regular Income: \$${regularIncome.toStringAsFixed(2)}"),
              Text("Overtime Income: \$${overtimeIncome.toStringAsFixed(2)}"),
              Text("Income Tax: \$${incomeTax.toStringAsFixed(2)}"),


              const Text("301520576"),
              const Text("Yung Pak Hong Patrick"),
            ]
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final double totalWeekValue;
  final double dayWeekValue;
  final String dayWeekText;

  ChartBar({this.totalWeekValue, this.dayWeekValue, this.dayWeekText});

  double get percentualValue {
    // print('>> $dayWeekText  --  $dayWeekValue  -- $totalWeekValue ');
    if( totalWeekValue == 0) {
      return 0;
    }
    double resultado = (dayWeekValue / totalWeekValue);
    // print('>> $dayWeekText  --  $dayWeekValue  -- $totalWeekValue  >> $resultado');
    return resultado;
  } 

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[

        Container(
          height: 20,
          child: FittedBox(
            child: Text(dayWeekValue.toStringAsFixed(2))
          )
        ),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0
                  ),
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(5), 
                ),
              ),
              FractionallySizedBox(
                heightFactor: percentualValue,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(5)
                  ),
                ),

              ),
            ],
          ),
          
        ),
        Text(dayWeekText),
      ],
      
    );
  }
}
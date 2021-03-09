import 'package:despesas_pessoais/components/chart_bar.dart';
import 'package:despesas_pessoais/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {

  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {

      final weekDay = DateTime.now().subtract(
        Duration(days: index)
      );

      
      
      double totalSumDay = 0.00;
      for (var item in recentTransactions) {
        bool sameDay = item.date.day == weekDay.day;
        bool sameMonth = item.date.month == weekDay.month;
        bool sameYear = item.date.year == weekDay.year;

        if(sameDay && sameMonth && sameYear){
          totalSumDay += item.value;
        }
        

      }

      // print(DateFormat.E().format(weekDay)[0]);
      // print(totalSum);

      return {'day': DateFormat.E().format(weekDay)[0], 'value': totalSumDay};

    }).reversed.toList();
  }

  double get totalWeekValue {
    return groupedTransactions.fold(0, (previousValue, element) => previousValue + element['value']);
  }

  @override
  Widget build(BuildContext context) {
    
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((item) {
            // return Text('${item['day']}: ${item['value']}');
            return Flexible(
              fit: FlexFit.tight,
                child: ChartBar(
                totalWeekValue: totalWeekValue,
                dayWeekValue: item['value'],
                dayWeekText: item['day'],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
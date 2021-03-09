import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {

  final List<Transaction> transactions;
  final void Function(String) onRemove;

  TransactionList({this.transactions, this.onRemove});

  @override
  Widget build(BuildContext context) {
    
    return  Container(

      height: 400,

      child: transactions.isEmpty 
        ? Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('Não há despesas cadastradas...'),
            ),
            Container(
              height: 200,
              child: Image.asset(
                'assets/img/card3-illust-v2_rocket.png',
                fit: BoxFit.cover
                )
            )
          ],
        ) 
        
        : ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (contextList, index) {

            final transaction = transactions[index];

            return Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 20
              ),
              child: ListTile(
                
                leading: CircleAvatar(
                  radius: 30,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: FittedBox(
                      child: Text('R\$ ${transaction.value}'),
                    ),
                  )
                ),

                title: Text(
                  transaction.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                subtitle: Text(
                  DateFormat('d MMM y').format(transaction.date)
                ),

                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => onRemove(transaction.id),
                ),

              ),
            );


            // return Card(
            //   child: Row(
            //     children: <Widget>[
            //       Container(
            //         margin: EdgeInsets.symmetric(
            //           horizontal: 15,
            //           vertical: 10
            //         ),
            //         decoration: BoxDecoration(
            //           border: Border.all(
            //             color: Theme.of(context).primaryColor,
            //             width: 2
            //           )
            //         ),
            //         padding: EdgeInsets.all(10),
            //         child: Text(
            //           'R\$ ${transaction.value.toStringAsFixed(2)}',
            //           style: TextStyle(
            //             fontWeight: FontWeight.bold,
            //             fontSize: 20,
            //             color: Theme.of(context).primaryColor
            //           ),
            //         ),
            //       ),
            //       Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: <Widget>[
            //           Text(
            //             transaction.title,
            //             style: TextStyle(
            //               fontWeight: FontWeight.bold,
            //               fontSize: 16,
            //             ),
            //           ),
            //           Text(
            //             DateFormat('d MMM y').format(transaction.date),
            //             style: TextStyle(
            //               color: Colors.grey[600] 
            //             ),
            //           ),

            //         ],
            //       )
            //     ],
            //   ),
            // );

          },

        
      ),
    );
  }
}

import 'package:despesas_pessoais/components/chart.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:despesas_pessoais/components/transaction_form.dart';
import 'package:despesas_pessoais/components/transaction_list.dart';
import 'models/transaction.dart';




void main() {
  runApp(PersonalExpenses());
}

class PersonalExpenses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber[700],
        fontFamily: 'Poppins'
      ),
    );
  }
}


class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();

}


class _HomePageState extends State<HomePage> {

  // Lista de transações
  final List<Transaction> _transactions = [
    // Transaction(
    //   id: 't0',
    //   title: 'Aluguel 0',
    //   value: 1300.00,
    //   date: DateTime.now().subtract(Duration(days: 33))
    // ),
    // Transaction(
    //   id: 't1',
    //   title: 'Aluguel',
    //   value: 1600.00,
    //   date: DateTime.now().subtract(Duration(days: 3))
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Condomínio',
    //   value: 600.00,
    //   date: DateTime.now()
    // )
  ];

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  // Adicionar transação
  _addTransaction(String title, double value, DateTime date) {

    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    // Estratégia para fechar modal
    Navigator.of(context).pop();

  }

  _deleteTransaction(String id) {

    setState(() {
      _transactions.removeWhere((element) => element.id == id);
    });

  }
  
  // Abrir formulário modal
  _openTransactionFormModal(BuildContext context) {

    showModalBottomSheet(context: context, builder: (_) {
      return TransactionForm(_addTransaction);
    });

  }



  @override
  Widget build(BuildContext context) {
    
    return Scaffold(

        appBar: AppBar(
          title: Text('Despesas Pessoais'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add), 
              onPressed: () => _openTransactionFormModal(context)
            )
          ],
        ),

        body: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[

              // Container(
              //   width: double.infinity,
              //   child: Card(
              //     color: Colors.blue,
              //     child: Text('Gráfico'),
              //     elevation: 5,
              //   ),
              // ),
              Chart(_recentTransactions),

              // TransactionUser()
              TransactionList(
                transactions: _transactions,
                onRemove: _deleteTransaction,
              ),
              

            ],
          ),
        ),

        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _openTransactionFormModal(context),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      );
  }
}
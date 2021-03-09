import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {

  final void Function(String, double, DateTime) onSubmit;
  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();

}



class _TransactionFormState extends State<TransactionForm> {
  
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  
  DateTime _selectedDate = DateTime.now();


  _submitForm(){

    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0;

    // Validação simples
    if(title.isEmpty || value <= 0 || _selectedDate == null ) {
      return;
    }

    widget.onSubmit(title, value, _selectedDate);

  }

  _showDatePicker() {
    showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(2020), 
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
      
    });
  }

  @override
  Widget build(BuildContext context) {
    // resolvendo problema de estouro de limite de tela ao usar teclado com o componente SingleChildScrollView
    return SingleChildScrollView(
      // Ajustatdo tamamnho vertical do formulário modal com Container e height
      child: Container(
        height: 280,
        child: Card( 
          
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Column(
              
              children: <Widget>[
                
                TextField(
                  // onChanged: (fieldValue) => title = fieldValue,
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Título'
                  ),
                ),

                TextField(
                  // onChanged: (fieldValue) => value = fieldValue,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  // Underline abaixo (_) indica que o parâmetro está sendo ignorado
                  onSubmitted: (_) => {},
                  controller: _valueController,
                  decoration: InputDecoration(
                    labelText: 'Valor R\$'
                  ),
                ),

                Container(
                  height: 60,
                  child: Row(
                    children: <Widget>[
                      Text(_selectedDate == null ? 'Data não selecionada' : 'Data Selecionada ${DateFormat('dd/MM/y').format(_selectedDate)}'),
                      TextButton(
                        onPressed: _showDatePicker, 
                        child: Text(
                          'Selecionar data',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold
                          ) 
                        ),
                      )
                    ],
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: Text(
                        'Cadastar Despesa',
                        // style: TextStyle(color: Theme.of(context).primaryColor),
                      ), 
                    ),
                  ],
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
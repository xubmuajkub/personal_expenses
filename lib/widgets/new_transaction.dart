import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime _selectedDate;

  final FocusNode amountFocusNode = FocusNode();
  final FocusNode chooseDateFocusNode = FocusNode();

  void _submitData(context) {
    if (amountController.text.isEmpty) {
      return;
    }
    final String enteredTitle = titleController.text;
    final double enteredAmount = double.parse(amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTransaction(enteredTitle, enteredAmount, _selectedDate);
    FocusScope.of(context).unfocus();
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
        context: context, 
        initialDate: DateTime.now(), 
        firstDate: DateTime(2020), 
        lastDate: DateTime.now()
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
    return Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleController,
                onSubmitted: (_) => amountFocusNode.requestFocus(),
                textInputAction: TextInputAction.next,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => chooseDateFocusNode.requestFocus(),
                focusNode: amountFocusNode,
              ),
              Container(
                height: 70,
                child: Row(children: <Widget>[
                  Expanded(
                    child: Text(_selectedDate == null ? 'No date chosen!' : 'Picked date: ${DateFormat.yMd().format(_selectedDate)}'),
                  ),
                  FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      onPressed: _presentDatePicker,
                      focusNode: chooseDateFocusNode,
                      child: Text('Choose Date', style: TextStyle(fontWeight: FontWeight.bold),)
                  )
                ],),
              ),
              RaisedButton(
                onPressed: () => _submitData(context),
                child: Text("Add Transaction"),
                textColor: Theme.of(context).textTheme.button.color,
                color: Theme.of(context).primaryColor,
              )
            ],
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = new TextEditingController();

  final amountController = new TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0) return;
    widget.addTx(enteredTitle, enteredAmount);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: "Expense Title",
                focusColor: Colors.teal,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.teal,
                  ),
                ),
              ),
              // onChanged: (val) => titleInput = val,
              controller: titleController,
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "Expense Amount",
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.teal,
                  ),
                ),
              ),
              // onChanged: (val) => amountInput = val,
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
            ),
            TextButton(
              onPressed: submitData,
              child: Text(
                'Add Transaction',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
            )
          ],
        ),
      ),
      elevation: 5,
    );
  }
}

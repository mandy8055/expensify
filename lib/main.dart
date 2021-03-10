import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    new Transaction(
      id: "t1",
      title: "New Shoes",
      amount: 1245.47,
      date: DateTime.now(),
    ),
    new Transaction(
      id: "t2",
      title: "New Pair of Socks",
      amount: 247.65,
      date: DateTime.now(),
    ),
  ];
  void _addNewTransaction(String txTitle, double txAmount) {
    var uuid = Uuid();
    final newTx = new Transaction(
      id: uuid.v4(),
      title: txTitle,
      amount: txAmount,
      date: DateTime.now(),
    );

    print(newTx.id);
    setState(() => _userTransactions.add(newTx));
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewTransaction(_addNewTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter App"),
        backgroundColor: Colors.teal,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Card(
                child: Text("CHART APPEARS here!!"),
                elevation: 5,
              ),
            ),
            new TransactionList(_userTransactions),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}

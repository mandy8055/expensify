import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/chart_bar.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;
      for (int i = 0; i < recentTransactions.length; i++) {
        if ((recentTransactions[i].date.day == weekDay.day) &&
            (recentTransactions[i].date.month == weekDay.month) &&
            (recentTransactions[i].date.year == weekDay.year)) {
          totalSum += recentTransactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 2),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(
        0.0, (sum, item) => sum + item['amount']);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactionValues.map((e) {
              return Flexible(
                fit: FlexFit.loose,
                child: ChartBar(
                  label: e['day'],
                  spendingAmount: e['amount'],
                  spendingPercentageOfTotal: totalSpending == 0
                      ? 0.0
                      : (e['amount'] as double) / totalSpending,
                ),
              );
            }).toList()),
      ),
    );
  }
}

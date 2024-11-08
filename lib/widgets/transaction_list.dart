import 'package:flutter/material.dart';
import 'package:xpinso/models/transaction_model.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<TransactionModel> transactions;
  final Function(TransactionModel) onViewTransactionDetails;

  TransactionList(this.transactions, this.onViewTransactionDetails);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (ctx, index) {
        final tx = transactions[index];
        return GestureDetector(
          onTap: () => onViewTransactionDetails(tx),
          child: Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: EdgeInsets.all(6),
                  child: FittedBox(
                    child: Text('\$${tx.amount}'),
                  ),
                ),
              ),
              title: Text(
                tx.title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Text(
                DateFormat.yMMMd().format(tx.date),
              ),
            ),
          ),
        );
      },
    );
  }
}

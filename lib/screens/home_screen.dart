import 'package:flutter/material.dart';
import 'package:xpinso/screens/add_transaction_screen.dart';
import 'package:xpinso/models/transaction_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<TransactionModel> _transactions = [];

  void _addTransaction(TransactionModel transaction) {
    setState(() {
      _transactions.add(transaction);
    });
  }

  void _showTransactionDetails(TransactionModel transaction) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(transaction.title),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Amount: \$${transaction.amount.toStringAsFixed(2)}'),
            Text('Category: ${transaction.category}'),
            Text('Date: ${transaction.date.toLocal().toString().split(' ')[0]}'),
            Text('Description: ${transaction.description}'),
            Text('Recurrence: ${transaction.recurrence}'),
          ],
        ),
        actions: [
          TextButton(
            child: Text('Close'),
            onPressed: () => Navigator.of(ctx).pop(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalBalance = _transactions.fold<double>(
      0.0,
          (sum, tx) => sum + tx.amount,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Budget Tracker'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.greenAccent, Colors.cyanAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Total Balance: \$${totalBalance.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleLarge, // Use headline6 or another style
                ),
                decoration: BoxDecoration(
                  color: Colors.redAccent[100],
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _transactions.length,
                itemBuilder: (ctx, index) {
                  final tx = _transactions[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16),
                      title: Text(tx.title, style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('${tx.amount.toStringAsFixed(2)} - ${tx.category}'),
                      onTap: () => _showTransactionDetails(tx),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => AddTransactionScreen(
                onAddTransaction: _addTransaction,
              ),
            ),
          );
        },
        child: Icon(Icons.add, size: 30),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
    );
  }
}

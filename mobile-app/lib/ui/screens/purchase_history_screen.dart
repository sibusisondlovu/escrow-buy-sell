import 'package:flutter/material.dart';
import 'package:mobile_app/data/product_data.dart';

import '../../models/transaction_model.dart';

class PurchaseHistoryScreen extends StatefulWidget {
  const PurchaseHistoryScreen({super.key});
  static const String id = "purchaseHistory";

  @override
  State<PurchaseHistoryScreen> createState() => _PurchaseHistoryScreenState();
}

class _PurchaseHistoryScreenState extends State<PurchaseHistoryScreen> {
  final List<TransactionModel> transactions = [
    TransactionModel(
      transactionId: 'T001',
      product: products[1],
      buyer: 'John Doe',
      seller: 'TechStore',
      amountPaid: 999.99,
      status: TransactionStatus.paid,
      transactionDate: DateTime.now().subtract(const Duration(days: 1)),
      transactionTime: DateTime.now(),
      paymentGateway: 'Stripe',
    ),
    TransactionModel(
      transactionId: 'T002',
      product: products[2],
      buyer: 'Jane Smith',
      seller: 'GadgetWorld',
      amountPaid: 499.99,
      status: TransactionStatus.shipped,
      transactionDate: DateTime.now().subtract(const Duration(days: 3)),
      transactionTime: DateTime.now(),
      paymentGateway: 'PayPal',
    ),
    TransactionModel(
      transactionId: 'T003',
      product: products[3],
      buyer: 'Alice Johnson',
      seller: 'AudioHub',
      amountPaid: 149.99,
      status: TransactionStatus.delivered,
      transactionDate: DateTime.now().subtract(const Duration(days: 5)),
      transactionTime: DateTime.now(),
      paymentGateway: 'Stripe',
    ),
    TransactionModel(
      transactionId: 'T004',
      product: products[4],
      buyer: 'Bob Brown',
      seller: 'WearableTech',
      amountPaid: 299.99,
      status: TransactionStatus.cancelled,
      transactionDate: DateTime.now().subtract(const Duration(days: 7)),
      transactionTime: DateTime.now(),
      paymentGateway: 'PayPal',
    ),
    TransactionModel(
      transactionId: 'T005',
      product: products[5],
      buyer: 'Carol White',
      seller: 'TechStore',
      amountPaid: 349.99,
      status: TransactionStatus.confirmed,
      transactionDate: DateTime.now().subtract(const Duration(days: 10)),
      transactionTime: DateTime.now(),
      paymentGateway: 'Stripe',
    ),
  ];

  Color _statusColor(TransactionStatus status) {
    switch (status) {
      case TransactionStatus.pending:
        return Colors.orange;
      case TransactionStatus.paid:
        return Colors.green;
      case TransactionStatus.shipped:
        return Colors.blue;
      case TransactionStatus.delivered:
        return Colors.teal;
      case TransactionStatus.confirmed:
        return Colors.purple;
      case TransactionStatus.released:
        return Colors.amber;
      case TransactionStatus.cancelled:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Purchase History'),
      ),
      body: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              onTap: () {
                Navigator.pushNamed(context, 'transactionProgressScreen',
                    arguments: transaction);
              },
              title: Text(transaction.product.title),
              subtitle: Text(
                  'Buyer: ${transaction.buyer}\nSeller: ${transaction.seller}\nAmount: \$${transaction.amountPaid.toStringAsFixed(2)}\nDate: ${transaction.transactionDate.toLocal().toShortDate()}'),
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _statusColor(transaction.status),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  transaction.status.toString().split('.').last.toUpperCase(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

extension DateFormat on DateTime {
  String toShortDate() {
    return '$day/$month/$year';
  }
}

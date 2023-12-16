import 'package:client/models/synchronization.dart';
import 'package:client/models/transaction.dart';

class AddressInfo {
  String title;
  final String id;
  double received;
  double sent;
  double balance;
  int numTransactions;
  List<Transaction> transactions;
  Synchronization synchronization = Synchronization.desynced;

  AddressInfo({
    required this.title,
    required this.id,
    required this.received,
    required this.sent,
    required this.balance,
    required this.numTransactions,
    required this.transactions,
  });

  factory AddressInfo.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'address': String addressId,
        'total_received': int received,
        'total_sent': int sent,
        'final_balance': int balance,
        'n_tx': int numTransactions,
        'txs':  List<dynamic> transactions,
      } =>
          AddressInfo(
            title: '',
            id: addressId,
            received: received.toDouble(),
            sent: sent.toDouble(),
            balance: balance.toDouble(),
            numTransactions: numTransactions,
            transactions: transactions.map(
              (transaction) => Transaction.fromJson(transaction as Map<String, dynamic>),
            ).toList(),
          ),
      _ => throw const FormatException('Failed to load address info.'),
    };
  }

  void updateSynchronization() {
    var totalFee = 0.0;

    for (final transaction in transactions) {
      totalFee += transaction.fee;
    }

    final calculatedBalance = received - (sent + totalFee);
    if (balance == calculatedBalance) {
      synchronization = Synchronization.synced;
    } else {
      synchronization = Synchronization.invalid;
    }
  }
}
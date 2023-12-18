import 'package:client/models/synchronization.dart';
import 'package:client/models/transaction.dart';

class AddressInfo {
  final double _balance;

  String title;
  final String id;
  double received;
  double sent;
  int numTransactions;
  List<Transaction> transactions;
  Synchronization synchronization = Synchronization.desynced;

  AddressInfo({
    required this.title,
    required this.id,
    required this.received,
    required this.sent,
    required balance,
    required this.numTransactions,
    required this.transactions,
  }) : _balance = balance;

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
              (transaction) => Transaction.fromJson(addressId, transaction as Map<String, dynamic>),
            ).toList(),
          ),
      _ => throw const FormatException('Failed to load address info.'),
    };
  }

  double get balance {
    var pendingBalance = 0.0;

    for (final transaction in transactions) {
      if (!transaction.isPending) continue;

      pendingBalance += transaction.valueToAddress;
    }

    return _balance - pendingBalance;
  }

  void updateSynchronization() {
    var pendingTotal = 0.0;
    for (final transaction in transactions) {
      if (!transaction.isPending) continue;

      pendingTotal += transaction.valueToAddress;
    }

    final calculatedBalance = received - (sent + pendingTotal);
    if (balance == calculatedBalance) {
      synchronization = Synchronization.synced;
    } else {
      synchronization = Synchronization.invalid;
    }
  }
}
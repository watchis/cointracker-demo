import 'package:client/models/transaction.dart';

class AddressInfo {
  String title;
  String id;
  double balance;
  List<Transaction> transactions;

  AddressInfo({
    required this.title,
    required this.id,
    required this.balance,
    required this.transactions,
  });
}
import 'dart:convert';

import 'package:client/components/notification_manager.dart';
import 'package:client/models/transaction.dart';
import 'package:http/http.dart';

import 'package:client/models/address_info.dart';
import 'package:client/network/request_builders/blockchain_api_request_builder.dart';

class Server {
  static final Server _server = Server._internal();

  static const int okResponse = 200;
  static const int fetchLimit = 50;

  static const String _addressFailure = 'Failed to retrieve address information.';
  static const String _transactionFailure = 'Failed to retrieve transaction information.';

  late final BlockchainAPIRequestBuilder _requestBuilder;
  late final NotificationManager _notificationManager;

  factory Server() {
    return _server;
  }

  Server._internal() :
        _requestBuilder = BlockchainAPIRequestBuilder(),
        _notificationManager = NotificationManager();

  // POST Requests
  // AddressInfo addAddress({required String addressId}) {}
  // void requestAddress({required String addressId}) {}
  // void deleteAddress({required String addressId}) {}
  // void editAddressTitle({required String addressId, required String newTitle}) {}


  // GET Requests
  Future<AddressInfo> getAddress({required String addressId}) async {
    final response = await get(Uri.parse(
      _requestBuilder.singleAddressRequest(addressId: addressId),
    ));

    if (response.statusCode == okResponse) {
      return AddressInfo.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    } else {
      _notificationManager.fireNotification('Code ${response.statusCode}: $_addressFailure');
      throw Exception(_addressFailure);
    }
  }

  Future<List<AddressInfo>> replaceAllAddresses({required List<AddressInfo> addresses}) async {
    final response = await get(Uri.parse(_requestBuilder.multiAddressRequest(addresses)));

    if (response.statusCode == okResponse) {
      final jsonAddresses = _unpackMultipleAddresses(
        jsonDecode(response.body) as Map<String, dynamic>,
      );

      return jsonAddresses.map(
        (response) => AddressInfo.fromJson(response),
      ).toList();
    } else {
      _notificationManager.fireNotification('Code ${response.statusCode}: $_addressFailure');
      throw Exception(_addressFailure);
    }
  }

  Future<List<Transaction>> getTransactionsForAddress({
    required String addressId,
    int offset = 0,
  }) async {
    final response = await get(Uri.parse(
      _requestBuilder.singleAddressRequest(addressId: addressId, offset: offset),
    ));

    if (response.statusCode == okResponse) {
      return AddressInfo.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      ).transactions.toList();
    } else {
      _notificationManager.fireNotification('Code ${response.statusCode}: $_transactionFailure');
      throw Exception(_transactionFailure);
    }
  }

  Future<List<Transaction>> getAllTransactionsForAddress({
    required AddressInfo address,
  }) async {
    final transactionsList = <Transaction>[];

    var numFetchedTransactions = 0;
    while(numFetchedTransactions < address.numTransactions) {
      final transactions = await _server.getTransactionsForAddress(
        addressId: address.id,
        offset: numFetchedTransactions,
      );

      numFetchedTransactions += Server.fetchLimit;
      transactionsList.addAll(transactions);
    }

    return Future(() => transactionsList);
  }

  List<Map<String, dynamic>> _unpackMultipleAddresses(Map<String, dynamic> responseBody) {
    return switch (responseBody) {
      {
        'addresses': List<dynamic> addresses,
      } =>
          addresses.map((address) {
            final addressMap = addresses as Map<String, dynamic>;
            addressMap['txs'] = [];
            return addressMap;
          }).toList(),
      _ => throw const FormatException('Failed to load addresses.'),
    };
  }
}
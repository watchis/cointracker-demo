import 'package:client/models/address_info.dart';
import 'package:client/models/synchronization.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AddressInfo', () {
    group('fromJson', () {
      const txnId = 'txnId', relayedBy = 'relayedBy';
      const inId = 100, inValue = 250;
      const outId = 500, outValue = 750;

      final txnJson = <String, dynamic>{
        'hash': txnId,
        'relayed_by': relayedBy,
        'inputs': [
          <String, dynamic>{
            'prev_out': <String, dynamic> {
              'tx_index': inId,
              'value': inValue,
            }
          }
        ],
        'out': [
          <String, dynamic>{
            'tx_index': outId,
            'value': outValue,
          }
        ],
      };

      test('well-formed json', () {
        const addressId = 'addressId';
        const received = 150, sent = 100, balance = 50;
        const numTransactions = 2;

        final json = <String, dynamic> {
          'address': addressId,
          'total_received': received,
          'total_sent': sent,
          'final_balance': balance,
          'n_tx': numTransactions,
          'txs':  [
            txnJson,
            txnJson,
          ],
        };

        final addressInfo = AddressInfo.fromJson(json);
        expect(addressInfo.id, addressId);
        expect(addressInfo.title, '');
        expect(addressInfo.synchronization, Synchronization.desynced);

        expect(addressInfo.sent, sent);
        expect(addressInfo.received, received);
        expect(addressInfo.balance, balance);

        expect(addressInfo.numTransactions, 2);
        expect(addressInfo.transactions.length, 2);
      });

      test('malformed json', () {
        final json = <String, dynamic>{};
        expect(() => AddressInfo.fromJson(json), throwsException);
      });
    });

    group('updateSynchronization', () {
      test('is synchronized', () {
        final addressInfo = AddressInfo(
          title: 'title',
          id: 'id',
          received: 300,
          sent: 200,
          balance: 100,
          numTransactions: 0,
          transactions: [],
        );

        expect(addressInfo.synchronization, Synchronization.desynced);
        addressInfo.updateSynchronization();
        expect(addressInfo.synchronization, Synchronization.synced);
      });

      test('is not synchronized', () {
        final addressInfo = AddressInfo(
          title: 'title',
          id: 'id',
          received: 300,
          sent: 200,
          balance: 999,
          numTransactions: 0,
          transactions: [],
        );

        expect(addressInfo.synchronization, Synchronization.desynced);
        addressInfo.updateSynchronization();
        expect(addressInfo.synchronization, Synchronization.invalid);
      });
    });
  });
}
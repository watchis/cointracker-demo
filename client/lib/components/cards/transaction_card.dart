import 'package:client/models/currency_converter.dart';
import 'package:client/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TransactionCard extends StatefulWidget {
  final Transaction transaction;

  const TransactionCard({
    super.key,
    required this.transaction,
  });

  @override
  State<StatefulWidget> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Column(
        children: [
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _getCardIcon(),
                Container(
                  padding: const EdgeInsets.only(left: 8),
                  width: MediaQuery.sizeOf(context).width / 1.6,
                  child: Text(
                    widget.transaction.id,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  alignment: Alignment.centerRight,
                  onPressed: _launchWindow,
                  icon: const Icon(Icons.open_in_new),
                ),
              ],
            )
          ),
          Container(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Column (
              children: [
                ..._transferAmountRow,
                _buildTextRow(
                  label: 'Fee',
                  value: currencyString(CurrencyType.satoshi, widget.transaction.fee),
                  valueColor: Colors.red,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getCardIcon() {
    if (widget.transaction.isPending) {
      return const Icon(Icons.pending, color: Colors.black38);
    }

    final isIncoming = widget.transaction.isIncoming;
    return Transform.flip(
      flipY: isIncoming,
      child: Icon(
        Icons.outbound,
        color: isIncoming ? Colors.green : Colors.red,
      ),
    );
  }

  List<Widget> get _transferAmountRow {
    final rows = <Widget>[];

    if (widget.transaction.addressOutput != 0) {
      rows.add(_buildTextRow(
        label: 'Incoming',
        value: currencyString(CurrencyType.bitcoin, widget.transaction.addressOutput),
        valueColor: Colors.green,
      ));
    }

    if (widget.transaction.addressInput != 0) {
      rows.add(_buildTextRow(
        label: 'Outgoing',
        value: currencyString(CurrencyType.bitcoin, -1 * widget.transaction.addressInput),
        valueColor: Colors.red,
      ));
    }

    return rows;
  }

  Widget _buildTextRow({
    required String label,
    required String value,
    required Color valueColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('$label:'),
        Text(
          value,
          style: TextStyle(color: valueColor),
        ),
      ],
    );
  }

  void _launchWindow() async {
    final txnId = widget.transaction.id;
    final Uri url = Uri.parse('https://www.blockchain.com/explorer/transactions/btc/$txnId');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
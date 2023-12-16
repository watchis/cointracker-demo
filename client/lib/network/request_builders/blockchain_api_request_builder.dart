import 'package:client/models/address_info.dart';

class BlockchainAPIRequestBuilder {
  static final BlockchainAPIRequestBuilder _builder = BlockchainAPIRequestBuilder._internal();

  static const int addressLimit = 100;

  factory BlockchainAPIRequestBuilder() {
    return _builder;
  }

  BlockchainAPIRequestBuilder._internal();

  String singleAddressRequest({
    required String addressId,
    int offset = 0,
  }) {
    return 'https://blockchain.info/rawaddr/$addressId?offset=$offset';
  }

  String multiAddressRequest(List<AddressInfo> addresses) {
    List<String> addressIds = addresses.map((address) => address.id).toList();
    String joinedAddresses = addressIds.join('|');
    return 'https://blockchain.info/multiaddr?active=$joinedAddresses';
  }
}
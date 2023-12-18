import 'package:client/models/io.dart';

class Transaction {
  final String _parentId;

  final String id;
  final List<IO> inputs;
  final List<IO> outputs;
  final bool isPending;

  double? _addressInput;
  double? _addressOutput;
  double? _fee;
  bool? _isIncoming;

  Transaction({
    required parentId,
    required this.id,
    required this.inputs,
    required this.outputs,
    required this.isPending,
  }) : _parentId = parentId;

  double get addressInput {
    if (_addressInput != null) return _addressInput!;

    var inputTotal = 0.0;
    for (final input in inputs) {
      if (input.targetAddressId != _parentId) continue;
      inputTotal += input.value;
    }
    return inputTotal;
  }

  double get addressOutput {
    if (_addressOutput != null) return _addressOutput!;

    var outputTotal = 0.0;
    for (final output in outputs) {
      if (output.targetAddressId != _parentId) continue;
      outputTotal += output.value;
    }

    return outputTotal;
  }

  double get valueToAddress {
    if (addressInput != 0) return addressInput;
    return addressOutput;
  }

  double get fee {
    if (_fee != null) return _fee!;

    var input = 0.0;
    for (final io in inputs) {
      input += io.value;
    }

    var output = 0.0;
    for (final io in outputs) {
      output += io.value;
    }

    return output - input;
  }

  bool get isIncoming {
    if (_isIncoming != null) return _isIncoming!;

    return outputs.any((output) => output.targetAddressId == _parentId);
  }

  factory Transaction.fromJson(String parentId, Map<String, dynamic> json) {
    return switch (json) {
      {
        'hash': String hashId,
        'block_index': int? blockIndex,
        'inputs': List<dynamic> inputs,
        'out': List<dynamic> outputs,
      } =>
          Transaction(
            parentId: parentId,
            id: hashId,
            inputs: inputs.map((inputJson) {
              return switch(inputJson as Map<String, dynamic>) {
                {
                  'prev_out': Map<String, dynamic> prevOut,
                } =>
                    IO.fromJson(prevOut),
                _ => throw const FormatException('Failed to load input on transaction.'),
              };
            }).toList(),
            outputs: outputs.map(
              (output) => IO.fromJson(output as Map<String, dynamic>),
            ).toList(),
            isPending: blockIndex == null,
          ),
      _ => throw const FormatException('Failed to load transaction.'),
    };
  }
}
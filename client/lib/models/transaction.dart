import 'package:client/models/io.dart';

class Transaction {
  final String id;
  final String relayedBy;
  final List<IO> inputs;
  final List<IO> outputs;

  double? _netInput;
  double? _netOutput;
  double? _fee;

  Transaction({
    required this.id,
    required this.relayedBy,
    required this.inputs,
    required this.outputs,
  });

  double get netInput {
    if (_netInput != null) return _netInput!;

    var inputTotal = 0.0;
    for (final input in inputs) {
      inputTotal += input.value;
    }
    return inputTotal;
  }

  double get netOutput {
    if (_netOutput != null) return _netOutput!;

    var outputTotal = 0.0;
    for (final output in outputs) {
      outputTotal += output.value;
    }
    return outputTotal;
  }

  double get fee {
    if (_fee != null) return _fee!;

    return netOutput - netInput;
  }

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'hash': String hashId,
        'relayed_by': String relayedBy,
        'inputs': List<dynamic> inputs,
        'out': List<dynamic> outputs,
      } =>
          Transaction(
            id: hashId,
            relayedBy: relayedBy,
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
          ),
      _ => throw const FormatException('Failed to load transaction.'),
    };
  }
}
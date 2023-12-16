class IO {
  final int id;
  final double value;

  const IO({
    required this.id,
    required this.value,
  });

  factory IO.fromJson(Map<String,dynamic> json) {
    return switch (json) {
      {
      'tx_index': int txnId,
      'value': int value,
      } =>
          IO(
            id: txnId,
            value: value.toDouble(),
          ),
      _ => throw const FormatException('Failed to load IO.'),
    };
  }
}
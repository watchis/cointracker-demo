class IO {
  final String targetAddressId;
  final double value;

  const IO({
    required this.targetAddressId,
    required this.value,
  });

  factory IO.fromJson(Map<String,dynamic> json) {
    return switch (json) {
      {
        'addr': String addressId,
        'value': int value,
      } =>
          IO(
            targetAddressId: addressId,
            value: value.toDouble(),
          ),
      _ => throw const FormatException('Failed to load IO.'),
    };
  }
}
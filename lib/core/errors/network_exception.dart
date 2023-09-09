class NetworkException implements Exception{
  final String message;
  int? code = 0;

  NetworkException({required this.message, this.code});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NetworkException && runtimeType == other.runtimeType && message == other.message && code == other.code;

  @override
  int get hashCode => message.hashCode ^ code.hashCode;
}
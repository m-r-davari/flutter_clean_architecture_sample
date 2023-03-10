class GeneralException implements Exception{
  final String message;
  int? code = 0;

  GeneralException({required this.message, this.code});
}
import 'package:flutter_clean_architecture_sample/core/errors/failure.dart';

class NetworkFailure extends Failure{

  final String _message;

  NetworkFailure(this._message);

  @override
  String get message => _message;

}
import 'package:flutter_clean_architecture_sample/core/errors/failure.dart';

class ServerFailure extends Failure{

  final String _message;

  ServerFailure(this._message);

  @override
  String get message => _message;

}
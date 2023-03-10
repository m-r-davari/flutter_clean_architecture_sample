import 'package:flutter_clean_architecture_sample/core/errors/failure.dart';

class GeneralFailure extends Failure{

  final String _message;

  GeneralFailure(this._message);

  @override
  String get message => _message;

}
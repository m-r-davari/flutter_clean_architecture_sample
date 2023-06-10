import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_sample/core/errors/failure.dart';

import '../entity/ip_entity.dart';

abstract class IIpUseCase{

  Future<Either<Failure?,IpEntity>> getIp();

}
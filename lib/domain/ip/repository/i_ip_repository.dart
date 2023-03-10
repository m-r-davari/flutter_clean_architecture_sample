
import 'package:flutter_clean_architecture_sample/domain/ip/entity/ip_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../core/errors/failure.dart';

abstract class IIpRepository {

  Future<Either<Failure?,IpEntity>> getIp();

}
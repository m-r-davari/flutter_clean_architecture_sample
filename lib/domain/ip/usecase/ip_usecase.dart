import 'package:flutter_clean_architecture_sample/domain/ip/entity/ip_entity.dart';
import 'package:flutter_clean_architecture_sample/domain/ip/repository/i_ip_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_sample/domain/ip/usecase/i_ip_usecase.dart';

import '../../../core/errors/failure.dart';

class IpUseCase extends IIpUseCase {

  final IIpRepository ipRepository;
  IpUseCase({required this.ipRepository});

  Future<Either<Failure?,IpEntity>> getIp()async{
    final result = await ipRepository.getIp();
    return result;
  }

}
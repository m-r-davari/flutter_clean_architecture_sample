import 'package:flutter_clean_architecture_sample/core/errors/failure.dart';
import 'package:flutter_clean_architecture_sample/core/errors/general_exception.dart';
import 'package:flutter_clean_architecture_sample/core/errors/general_failure.dart';
import 'package:flutter_clean_architecture_sample/data/ip/datasource/remote/i_ip_remote_datasource.dart';
import 'package:flutter_clean_architecture_sample/data/ip/model/ip_model.dart';
import 'package:flutter_clean_architecture_sample/domain/ip/entity/ip_entity.dart';
import 'package:flutter_clean_architecture_sample/domain/ip/repository/i_ip_repository.dart';
import 'package:dartz/dartz.dart';

class IpRepository extends IIpRepository {

  final IIpRemoteDataSource ipRemoteDataSource;

  IpRepository({required this.ipRemoteDataSource});

  @override
  Future<Either<Failure?, IpEntity>> getIp()async{
    try{
      IpModel result = await ipRemoteDataSource.getIp();
      return Right(IpEntity.fromModel(result));
    }
    on GeneralException catch (exc){
      return Left(GeneralFailure(exc.message));
    }
  }

}



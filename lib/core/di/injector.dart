import 'package:flutter_clean_architecture_sample/data/ip/datasource/remote/i_ip_remote_datasource.dart';
import 'package:flutter_clean_architecture_sample/data/ip/datasource/remote/ip_remote_datasource.dart';
import 'package:flutter_clean_architecture_sample/data/ip/repository/ip_repository.dart';
import 'package:flutter_clean_architecture_sample/domain/ip/repository/i_ip_repository.dart';
import 'package:flutter_clean_architecture_sample/domain/ip/usecase/ip_usecase.dart';
import 'package:flutter_clean_architecture_sample/resources/const_keeper.dart';
import 'package:get_it/get_it.dart';
import '../network/dio_api_request_manager.dart';
import '../network/i_api_request_manager.dart';

GetIt injector = GetIt.instance;

void injectDependencies(){

  injector.registerSingleton<IApiRequestManager>(DioApiRequestManager(baseUrl: ConstKeeper.baseUrl));
  injector.registerFactory<IIpRemoteDataSource>(() => IpRemoteDataSource(requestManager: injector<IApiRequestManager>()));
  injector.registerFactory<IIpRepository>(() => IpRepository(ipRemoteDataSource: injector<IIpRemoteDataSource>()));
  injector.registerFactory<IpUseCase>(() => IpUseCase(ipRepository: injector<IIpRepository>()));

}
import 'package:flutter_clean_architecture_sample/core/errors/general_exception.dart';
import 'package:flutter_clean_architecture_sample/core/errors/network_exception.dart';
import 'package:flutter_clean_architecture_sample/core/network/i_api_request_manager.dart';
import '../../model/ip_model.dart';
import 'i_ip_remote_datasource.dart';


class IpRemoteDataSource extends IIpRemoteDataSource {

  final IApiRequestManager requestManager;

  IpRemoteDataSource({required this.requestManager});

  @override
  Future<IpModel> getIp()async{
    try{
      final result = await requestManager.getRequest(path: 'ip.json');
      return IpModel.fromJson(result);
    }
    on NetworkException catch(_){
      rethrow;
    }
    catch (exc){
      throw GeneralException(message: exc.toString());
    }

  }

}
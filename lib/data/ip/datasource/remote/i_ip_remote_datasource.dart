import '../../model/ip_model.dart';

abstract class IIpRemoteDataSource {

  Future<IpModel> getIp();

}

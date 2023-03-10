abstract class IApiRequestManager {

  Future<dynamic> getRequest({required String path,Map<String,dynamic>? params, Map<String,dynamic>? headers});

  Future<dynamic> postRequest({required String path,Map<String,dynamic>? params, Map<String,dynamic>? headers, required dynamic body});

}
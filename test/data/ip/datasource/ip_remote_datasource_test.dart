
import 'package:flutter_clean_architecture_sample/core/errors/network_exception.dart';
import 'package:flutter_clean_architecture_sample/core/network/i_api_request_manager.dart';
import 'package:flutter_clean_architecture_sample/data/ip/datasource/remote/ip_remote_datasource.dart';
import 'package:flutter_clean_architecture_sample/data/ip/model/ip_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';



@GenerateNiceMocks([MockSpec<IApiRequestManager>()])
import 'ip_remote_datasource_test.mocks.dart';


/*class MockNetwork extends Mock implements IApiRequestManager {
  @override
  Future getRequest({required String? path, Map<String, dynamic>? params, Map<String, dynamic>? headers})async{
    final tempIpModelResponse = {'success': true, 'ip': '172.192.1.1', 'type': 'local'};
    return await Future.value(tempIpModelResponse);
  }
}*/

void main() async {
  //final requestManager = MockNetwork();

  final mockRequestManager = MockIApiRequestManager();
  late IpRemoteDataSource ipRemoteDataSource;

  setUp(() {
    ipRemoteDataSource = IpRemoteDataSource(requestManager: mockRequestManager);
  });


  group('test ip remote data source', () {

    test('test success ip api call', () async {
      final tempIpModelResponse = {'success': true, 'ip': '172.192.1.1', 'type': 'local'};
      when(mockRequestManager.getRequest(path: anyNamed('path'), params: null, headers: null)).thenAnswer((_) async => tempIpModelResponse);
      final result = await ipRemoteDataSource.getIp();
      expect(result.success, true);
      expect(result, isA<IpModel>());
      expect(result, equals(IpModel(success: true,ip: '172.192.1.1',type: 'local')));
    });

    test('testing timeout error', ()async{
      when(mockRequestManager.getRequest(path: anyNamed('path'))).thenThrow(NetworkException(message: 'timeout error'));
      expect(() async => await ipRemoteDataSource.getIp(), throwsA(isA<NetworkException>()));
      expect(()async => await ipRemoteDataSource.getIp(), throwsA(equals(NetworkException(message: 'timeout error'))));
    });

  });


}
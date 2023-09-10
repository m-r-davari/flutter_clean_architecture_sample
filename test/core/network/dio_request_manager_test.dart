

import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture_sample/core/errors/network_exception.dart';
import 'package:flutter_clean_architecture_sample/core/network/dio_api_request_manager.dart';
import 'package:flutter_clean_architecture_sample/resources/const_keeper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';



@GenerateNiceMocks([MockSpec<Dio>()])
import 'dio_request_manager_test.mocks.dart';


void main()async{

  final mockDio = MockDio();
  late DioApiRequestManager dioApiRequestManager;

  setUp((){
    dioApiRequestManager = DioApiRequestManager(baseUrl: ConstKeeper.baseUrl);
    dioApiRequestManager.dio = mockDio;
  });


  test('test get method of request manager', ()async{

    final tempJson = {
      'success': true,
      'type': 'local',
      'ip': '192.168.1.1'
    };

    final Response<dynamic> tempResponse = Response(data: tempJson, requestOptions: RequestOptions());
    when(mockDio.get(any,queryParameters: null,data: null,cancelToken: null, onReceiveProgress: null,options: anyNamed('options'))).thenAnswer((Invocation realInvocation) async=> tempResponse);
    final result = await dioApiRequestManager.getRequest(path: 'any');
    expect(result, tempResponse.data);

  });


  test('test get method errors', ()async{

    when(mockDio.get(any,data: null,queryParameters: null,options: anyNamed('options'))).thenThrow(NetworkException(message: 'connection failed'));
    expect(()async =>await dioApiRequestManager.getRequest(path: 'any'), throwsA(isA<NetworkException>()));

  });



}
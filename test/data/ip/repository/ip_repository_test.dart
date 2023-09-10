
import 'package:flutter_clean_architecture_sample/core/errors/general_failure.dart';
import 'package:flutter_clean_architecture_sample/data/ip/datasource/remote/i_ip_remote_datasource.dart';
import 'package:flutter_clean_architecture_sample/data/ip/model/ip_model.dart';
import 'package:flutter_clean_architecture_sample/data/ip/repository/ip_repository.dart';
import 'package:flutter_clean_architecture_sample/domain/ip/entity/ip_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<IIpRemoteDataSource>()])
import 'ip_repository_test.mocks.dart';

void main()async{

  final mockRemoteDataSource = MockIIpRemoteDataSource();
  late IpRepository ipRepository;

  setUp((){
    ipRepository = IpRepository(ipRemoteDataSource: mockRemoteDataSource);
  });


  group('ip repository test', () {

    test('test success get ip from repository ', ()async{
      final tempIpModel = IpModel(success: true,ip: '192.168.1.1',type: 'local');
      when(mockRemoteDataSource.getIp()).thenAnswer((_)async=> tempIpModel);
      final result = await ipRepository.getIp();
      late IpEntity data;
      result.fold((l) => null, (r) {
        data = IpEntity.fromModel(tempIpModel);
      });

      expect(result.isRight(), true);
      expect(data, isA<IpEntity>());
      expect(data.success,true);
      expect(data, equals(IpEntity(ip: '192.168.1.1', type: 'local', success: true)));

    });

    test('test failure get ip from repository',()async{
      when(mockRemoteDataSource.getIp()).thenThrow(GeneralFailure('Something went wrong'));
      final result = await ipRepository.getIp();
      expect(result.isLeft(),true);
      result.fold((l) {
        expect(l, isA<GeneralFailure>());
      }, (r) => null);
    });

  });



}
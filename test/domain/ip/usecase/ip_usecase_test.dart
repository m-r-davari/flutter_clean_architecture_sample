import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_sample/core/errors/failure.dart';
import 'package:flutter_clean_architecture_sample/core/errors/general_failure.dart';
import 'package:flutter_clean_architecture_sample/domain/ip/entity/ip_entity.dart';
import 'package:flutter_clean_architecture_sample/domain/ip/repository/i_ip_repository.dart';
import 'package:flutter_clean_architecture_sample/domain/ip/usecase/ip_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<IIpRepository>()])
import 'ip_usecase_test.mocks.dart';


void main()async{

  final mockIpRepository = MockIIpRepository();
  late IpUseCase ipUseCase;


  setUp(() {
    ipUseCase = IpUseCase(ipRepository: mockIpRepository);
  });

  test('test get ip use case method success', ()async{
    final Either<Failure?,IpEntity> tempEither = Right(IpEntity(ip: '192.168.1.1',type: 'local',success: true));
    when(mockIpRepository.getIp()).thenAnswer((realInvocation) async=> tempEither);
    final result = await ipUseCase.getIp();
    expect(result.isRight(), true);
  });


  test('test get ip use case method failed', ()async{
    when(mockIpRepository.getIp()).thenThrow(GeneralFailure('failed in use case logic'));
    final result = await ipUseCase.getIp();
    expect(result.isLeft(), true);
  });


}
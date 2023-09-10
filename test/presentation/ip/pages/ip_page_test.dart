import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_sample/core/di/injector.dart';
import 'package:flutter_clean_architecture_sample/core/errors/general_failure.dart';
import 'package:flutter_clean_architecture_sample/core/states/ui_state.dart';
import 'package:flutter_clean_architecture_sample/domain/ip/entity/ip_entity.dart';
import 'package:flutter_clean_architecture_sample/domain/ip/usecase/i_ip_usecase.dart';
import 'package:flutter_clean_architecture_sample/presentation/ip/pages/ip_page.dart';
import 'package:flutter_clean_architecture_sample/presentation/ip/providers/ip_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:provider/provider.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<IIpUseCase>()])
import 'ip_page_test.mocks.dart';

void main(){

  final mockIpUseCase = MockIIpUseCase();
  late IpProvider ipProvider ;

  setUp(() {
    ipProvider = IpProvider(ipUseCase: mockIpUseCase);
  });

  group('tests for ip pag', () {

    testWidgets('find appbar in ip page', (tester)async{
      injectDependencies();
      await tester.pumpWidget(MaterialApp(home: IpPage(),));
      await tester.pumpAndSettle();
      expect(find.widgetWithText(AppBar, 'IP Page'), findsOneWidget);
    });


    testWidgets('test loading state for ip page',(tester)async{
      when(mockIpUseCase.getIp()).thenAnswer((_) async => Right(IpEntity(ip: '192.168.1.1',type: 'local',success: true)));
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider<IpProvider>(
            create: (context)=> ipProvider,
            child: const IpPageBodyContent(),
          ),
        )
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byType(Text), findsNothing);
      expect(find.byType(IconButton), findsNothing);

    });


    testWidgets('test success state for ip page',(tester)async{
      final ipEntity = IpEntity(ip: '192.168.1.1',type: 'local',success: true);
      when(mockIpUseCase.getIp()).thenAnswer((_) async => Right(ipEntity));
      await tester.pumpWidget(
          MaterialApp(
            home: ChangeNotifierProvider<IpProvider>(
              create: (context) {
                ipProvider.ipUiState = SuccessState(ipEntity);
                return ipProvider;
              },
              child: const IpPageBodyContent(),
            ),
          )
      );

      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byType(Text), findsAtLeastNWidgets(3));
      expect(find.byType(IconButton), findsNothing);

    });


    testWidgets('test failure state for ip page',(tester)async{
      when(mockIpUseCase.getIp()).thenAnswer((_) async => Left(GeneralFailure('state failure')));
      await tester.pumpWidget(
          MaterialApp(
            home: ChangeNotifierProvider<IpProvider>(
              create: (context) {
                ipProvider.ipUiState = FailureState('state failure');
                return ipProvider;
              },
              child: const Scaffold(body: IpPageBodyContent()),
            ),
          )
      );
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byType(Text), findsOneWidget);
      expect(find.byType(IconButton), findsOneWidget);

    });

  });



}
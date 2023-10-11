import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_sample/core/errors/general_failure.dart';
import 'package:flutter_clean_architecture_sample/core/states/ui_state.dart';
import 'package:flutter_clean_architecture_sample/domain/ip/entity/ip_entity.dart';
import 'package:flutter_clean_architecture_sample/domain/ip/usecase/i_ip_usecase.dart';
import 'package:flutter_clean_architecture_sample/presentation/ip/with_riverpod/notifiers/ip_notifier.dart';
import 'package:flutter_clean_architecture_sample/presentation/ip/with_riverpod/pages/ip_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';


@GenerateNiceMocks([MockSpec<IIpUseCase>()])
import 'ip_page_test.mocks.dart';

void main()async{

  final mockIpUseCase = MockIIpUseCase();

  testWidgets('Test For loading state of ip page with river pod', (tester)async{
    final ipProvider = StateNotifierProvider<IpNotifier, UIState>((ref){
      return IpNotifier(ipUseCase: mockIpUseCase);
    });
    final ipPageBody = IpPageBodyContent(ipProvider: ipProvider,);
    await tester.pumpWidget(ProviderScope(child: MaterialApp(home: ipPageBody)));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });


  testWidgets('testing success state for ip page', (tester)async{
    final ipEntity = IpEntity(ip: '192.168.1.1',type: 'local',success: true);
    final ipProvider = StateNotifierProvider<IpNotifier, UIState>((ref){
      final ipNotifier = IpNotifier(ipUseCase: mockIpUseCase);
      Future.delayed(Duration.zero,(){
        //ipNotifier.changeState(SuccessState(ipEntity));
        ipNotifier.state= SuccessState(ipEntity);
      });
      return ipNotifier;
    });
    final ipPageBody = IpPageBodyContent(ipProvider: ipProvider,);
    await tester.pumpWidget(ProviderScope(child: MaterialApp(home: ipPageBody)));
    await tester.pumpAndSettle();
    expect(find.byType(Text), findsAtLeastNWidgets(3));
  });

  testWidgets('testing failure state for ip page', (tester)async{
    final ipProvider = StateNotifierProvider<IpNotifier, UIState>((ref){
      final ipNotifier = IpNotifier(ipUseCase: mockIpUseCase);
      Future.delayed(Duration.zero,(){
        //ipNotifier.changeState(FailureState('failed'));
        ipNotifier.state = FailureState('failed');
      });
      return ipNotifier;
    });
    final ipPageBody = IpPageBodyContent(ipProvider: ipProvider,);
    await tester.pumpWidget(ProviderScope(child: MaterialApp(home: Scaffold(body: ipPageBody,))));
    await tester.pumpAndSettle();
    expect(find.byType(Text), findsOneWidget);
    expect(find.byType(IconButton), findsOneWidget);
  });



  testWidgets('test auto states', (tester)async{
    when(mockIpUseCase.getIp()).thenAnswer((_) async=> Left(GeneralFailure('failed')));
    final ipProvider = StateNotifierProvider<IpNotifier, UIState>((ref){
      final ipNotifier = IpNotifier(ipUseCase: mockIpUseCase);
      Future.delayed(Duration.zero,(){
        ipNotifier.fetchIp();
      });
      return ipNotifier;
    });

    await tester.pumpWidget(ProviderScope(child: MaterialApp(home: Scaffold(body: IpPageBodyContent(ipProvider: ipProvider,),),)));
    await tester.pumpAndSettle();
    expect(find.byType(Text), findsOneWidget);
    expect(find.byType(IconButton), findsOneWidget);

  });


}
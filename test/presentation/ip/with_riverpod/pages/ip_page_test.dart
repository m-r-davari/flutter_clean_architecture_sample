import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_sample/core/states/ui_state.dart';
import 'package:flutter_clean_architecture_sample/domain/ip/entity/ip_entity.dart';
import 'package:flutter_clean_architecture_sample/domain/ip/usecase/i_ip_usecase.dart';
import 'package:flutter_clean_architecture_sample/presentation/ip/with_riverpod/notifiers/ip_notifier.dart';
import 'package:flutter_clean_architecture_sample/presentation/ip/with_riverpod/pages/ip_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';


@GenerateNiceMocks([MockSpec<IIpUseCase>()])
import 'ip_page_test.mocks.dart';

void main()async{

  final mockIpUseCase = MockIIpUseCase();

  testWidgets('Test For loading state of ip page with river pod', (tester)async{
    final ipProvider = NotifierProvider<IpNotifier, UIState>((){
      return IpNotifier(ipUseCase: mockIpUseCase);
    });
    final ipPageBody = IpPageBodyContent();
    ipPageBody.ipProvider = ipProvider;
    await tester.pumpWidget(ProviderScope(child: MaterialApp(home: ipPageBody)));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });


  testWidgets('testing success state for ip page', (tester)async{
    final ipEntity = IpEntity(ip: '192.168.1.1',type: 'local',success: true);
    final ipProvider = NotifierProvider<IpNotifier, UIState>((){
      final ipNotifier = IpNotifier(ipUseCase: mockIpUseCase);
      Future.delayed(Duration.zero,(){ipNotifier.changeState(SuccessState(ipEntity));});
      return ipNotifier;
    });
    final ipPageBody = IpPageBodyContent();
    ipPageBody.ipProvider = ipProvider;
    await tester.pumpWidget(ProviderScope(child: MaterialApp(home: ipPageBody)));
    await tester.pumpAndSettle();
    expect(find.byType(Text), findsAtLeastNWidgets(3));
  });

  testWidgets('testing failure state for ip page', (tester)async{
    final ipProvider = NotifierProvider<IpNotifier, UIState>((){
      final ipNotifier = IpNotifier(ipUseCase: mockIpUseCase);
      Future.delayed(Duration.zero,(){ipNotifier.changeState(FailureState('failed'));});
      return ipNotifier;
    });
    final ipPageBody = IpPageBodyContent();
    ipPageBody.ipProvider = ipProvider;
    await tester.pumpWidget(ProviderScope(child: MaterialApp(home: Scaffold(body: ipPageBody,))));
    await tester.pumpAndSettle();
    expect(find.byType(Text), findsOneWidget);
    expect(find.byType(IconButton), findsOneWidget);
  });


}
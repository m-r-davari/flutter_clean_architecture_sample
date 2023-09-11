

import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_sample/core/di/injector.dart';
import 'package:flutter_clean_architecture_sample/presentation/home/pages/home_page.dart';
import 'package:flutter_clean_architecture_sample/presentation/ip/with_provider/pages/ip_page.dart';
import 'package:flutter_test/flutter_test.dart';

void main()async{

  group('Test for home page', () {

    testWidgets('find app bar with desire title', (WidgetTester tester)async{
      await tester.pumpWidget(const MaterialApp(home: HomePage(),));
      expect(find.widgetWithText(AppBar, 'Flutter Clean Architecture Sample'), findsOneWidget);
    });


    testWidgets('find app bar with desire title', (WidgetTester tester)async{
      await tester.pumpWidget(const MaterialApp(home: HomePage(),));
      expect(find.text('Whats My IP'), findsOneWidget);
    });

  });


  testWidgets('press ip btn', (tester)async{
    injectDependencies();
    await tester.pumpWidget(const MaterialApp(home: HomePage(),));
    await tester.tap(find.widgetWithText(ElevatedButton, 'Whats My IP'));
    await tester.pumpAndSettle();
    expect(find.byType(IpPage), findsOneWidget);
  });



}
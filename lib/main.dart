import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_sample/presentation/home/pages/home_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/di/injector.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  injectDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }

}


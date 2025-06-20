import 'package:workerr/Home.dart';
import 'package:workerr/Login.dart';
import 'package:workerr/shared_prefrenses_helper.dart';

import 'package:flutter/material.dart';

import 'dio_helper.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CachHelper.init();
  runApp( MyApp());
}
class MyApp extends StatelessWidget {

  String check=  CachHelper.getData(key:'token').toString();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: check=='null' ?Login():Home(),
    );
  }
}



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reversi/reversi/view/reversimain.dart';
import 'package:reversi/reversiai/view/reversiaimain.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'unel.bt.reversi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.green,
          textTheme:
              const TextTheme(bodyText2: TextStyle(color: Colors.white))),
      home: const ReversiMain(),
    );
  }
}

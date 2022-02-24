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
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Brain Games Enki "),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                SizedBox(
                  width: 120,
                  child: ElevatedButton(
                    onPressed: () => Get.to(const ReversiMain()),
                    child: const Text("Reversi"),
                  ),
                ),
                SizedBox(
                  width: 120,
                  child: ElevatedButton(
                    onPressed: () => Get.to(const ReversiAIMain()),
                    child: const Text("Reversi - AI"),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "This project prepare for Brain Games Enki on Google Play and App Store",
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    ));
  }
}

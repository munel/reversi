import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reversi/reversiai/controller/reversiaicontroller.dart';
import 'package:reversi/reversiai/view/reversiaibilgi.dart';
import 'package:reversi/reversiai/view/reversiaitahta.dart';

class ReversiAIMain extends StatefulWidget {
  const ReversiAIMain({Key? key}) : super(key: key);

  @override
  _ReversiAIMainState createState() => _ReversiAIMainState();
}

class _ReversiAIMainState extends State<ReversiAIMain> {
  ReversiAIController reversiController = Get.put(ReversiAIController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Reversi - AI"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              child: FittedBox(
                child: ReversiAITahta(),
              ),
            ),
            Expanded(child: ReversiAIBilgi())
          ],
        ),
      ),
    );
  }
}

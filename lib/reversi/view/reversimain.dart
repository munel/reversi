import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reversi/reversi/controller/reversicontroller.dart';
import 'package:reversi/reversi/view/reversibilgi.dart';
import 'package:reversi/reversi/view/reversitahta.dart';

class ReversiMain extends StatefulWidget {
  const ReversiMain({Key? key}) : super(key: key);

  @override
  _ReversiMainState createState() => _ReversiMainState();
}

class _ReversiMainState extends State<ReversiMain> {
  ReversiController reversiController = Get.put(ReversiController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Reversi"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              child: FittedBox(
                child: ReversiTahta(),
              ),
            ),
            Expanded(child: ReversiBilgi())
          ],
        ),
      ),
    );
  }
}

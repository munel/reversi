import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reversi/reversiai/controller/reversiaicontroller.dart';

import 'package:reversi/widgets/pullar.dart';

class Deneme extends StatefulWidget {
  const Deneme({Key? key}) : super(key: key);

  @override
  _DenemeState createState() => _DenemeState();
}

class _DenemeState extends State<Deneme> {
  ReversiAIController reversiAIController = Get.put(ReversiAIController());
  late Widget w;
  bool degistir = true;
  List<String> degerler = ["s", "s", "s"];
  @override
  void initState() {
    super.initState();
    w = const SiyahPul();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Wrap(
        children: List.generate(3, (index) {
          return GetBuilder<ReversiAIController>(
              id: "$index",
              builder: (_) {
                return Center(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: degerler[index] == "s"
                        ? const SiyahPul()
                        : const BeyazPul(),
                    transitionBuilder: (child, animation) =>
                        FadeTransition(opacity: animation, child: child),
                  ),
                );
              });
        }),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.ac_unit),
        onPressed: () {
          degerler[0] = "b";
          degerler[1] = "b";
          degerler[2] = "b";
          List.generate(3, (index) {
            Future.delayed(Duration(seconds: index + 1), () {
              reversiAIController.update(["$index"]);
            });
          });
        },
      ),
    );
  }
}

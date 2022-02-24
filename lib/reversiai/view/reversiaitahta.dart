import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reversi/reversiai/controller/reversiaicontroller.dart';
import 'package:reversi/widgets/pullar.dart';

class ReversiAITahta extends StatelessWidget {
  final ReversiAIController reversiController = Get.find();
  ReversiAITahta({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 8),
        color: Colors.green.shade700,
      ),
      padding: const EdgeInsets.all(2),
      child: Column(
        children: List.generate(8, (i) {
          return Row(
            children: List.generate(8, (j) {
              int sira = (i * 8) + j;

              return GetBuilder<ReversiAIController>(
                  id: sira.toString(),
                  builder: (_) {
                    return hangiTasWidget(sira);
                  });
            }),
          );
        }),
      ),
    );
  }

  Widget hangiTasWidget(int sira) {
    if (reversiController.liste[sira] != "0") {
      return Container(
          margin: const EdgeInsets.all(2),
          width: 50,
          height: 50,
          decoration: BoxDecoration(border: Border.all()),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 100),
            child: reversiController.liste[sira] == "s"
                ? const SiyahPul()
                : const BeyazPul(),
            transitionBuilder: (child, animation) =>
                ScaleTransition(scale: animation, child: child),
          ));
    } else {
      return InkWell(
        onTap: () {
          if (reversiController.tiklanabilirMi) {
            reversiController.tiklandi(sira);
          }
        },
        child: Container(
          margin: const EdgeInsets.all(2),
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          // child: Text(sira.toString()),
        ),
      );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reversi/reversiai/controller/reversiaicontroller.dart';

class ReversiAIBilgi extends StatelessWidget {
  ReversiAIBilgi({Key? key}) : super(key: key);
  final ReversiAIController reversiController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReversiAIController>(
        id: "oyunici",
        builder: (_) {
          if (reversiController.beyazlar == 0 &&
              reversiController.siyahlar == 0) {
            String kimde = _.sira == "s" ? "Black" : "White";
            return Container(
              padding: const EdgeInsets.all(2),
              margin: const EdgeInsets.all(6),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(width: 4),
                color: Colors.green.shade600,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          const Text(
                            "YOU",
                            style: TextStyle(fontSize: 30),
                          ),
                          Text(
                            "Black : ${reversiController.siyahSayisi()}",
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text(
                            "AI",
                            style: TextStyle(fontSize: 30),
                          ),
                          Text(
                            "White : ${reversiController.beyazSayisi()}",
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    kimde == "Black" ? "YOU" : "AI",
                    style: const TextStyle(fontSize: 30),
                  ),
                ],
              ),
            );
          } else {
            String kazanan = "";
            if (reversiController.beyazlar > reversiController.siyahlar) {
              kazanan = "Winner : White";
            } else if (reversiController.beyazlar <
                reversiController.siyahlar) {
              kazanan = "Winner : Black";
            } else {
              kazanan = "Draw";
            }
            return Container(
              padding: const EdgeInsets.all(2),
              margin: const EdgeInsets.all(6),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(width: 4),
                color: Colors.green.shade700,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        reversiController.tekrarOyna();
                      },
                      child: const Text("Play Again")),
                  Text(
                    kazanan,
                    style: const TextStyle(fontSize: 25),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Black : ${reversiController.siyahlar}"),
                      Text("White : ${reversiController.beyazlar}")
                    ],
                  )
                ],
              ),
            );
          }
        });
  }
}

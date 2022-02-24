import 'package:flutter/material.dart';
import 'package:reversi/reversi/controller/reversicontroller.dart';

class SiyahPul extends StatelessWidget {
  const SiyahPul({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        gradient: RadialGradient(
          stops: const [0.2, 0.7],
          colors: [
            Colors.grey.shade600,
            Colors.black,
          ],
        ),
      ),
      // child widget, replace with your own
    );
  }
}

class BeyazPul extends StatelessWidget {
  const BeyazPul({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        gradient: RadialGradient(
          stops: const [0.2, 0.7],
          colors: [
            Colors.grey.shade400,
            Colors.white,
          ],
        ),
      ),
      // child widget, replace with your own
    );
  }
}


class DonusumluTaslar extends StatelessWidget {
  const DonusumluTaslar({
    Key? key,
    required this.reversiController,
    required this.sira
  }) : super(key: key);

  final ReversiController reversiController;
  final int sira;

  @override
  Widget build(BuildContext context) {
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
  }
}

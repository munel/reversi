class ReversiModel {
  late int x;
  late int y;
  late String renk;
  ReversiModel(this.x, this.y, this.renk);

  @override
  String toString() {
    return "$x, $y, $renk";
  }
}

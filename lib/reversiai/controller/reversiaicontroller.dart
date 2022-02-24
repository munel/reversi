import 'package:get/get.dart';
import 'package:reversi/reversiai/controller/aicontroller.dart';
import 'package:reversi/reversiai/controller/hamleyapilabilirmi.dart';
import 'package:reversi/trivia/showinf.dart';

class ReversiAIController extends GetxController {
  late List<String> liste;
  String sira = "s";
  late List<int> cevrilecekler;
  late bool tiklanabilirMi;
  HamleYapilabilirMi hamleYapilabilirMi = HamleYapilabilirMi();
  AiController aiController = AiController();
  int beyazlar = 0;
  int siyahlar = 0;
  ReversiAIController() {
    hazirlik();
  }

  void hazirlik() {
    cevrilecekler = [];
    tiklanabilirMi = true;
    liste = List.filled(64, "0", growable: false);
    beyazlar = 0;
    siyahlar = 0;
    liste[27] = "b";
    liste[36] = "b";
    liste[28] = "s";
    liste[35] = "s";

   
  }

  void tiklandi(int tiklanan) {
    cevrilecekler = [];
    var kontrolYerleri = farkliRenktemi(tiklanan);

    if (kontrolYerleri.isNotEmpty) {
      kendiRengimVarmi(tiklanan, kontrolYerleri);
    }
    if (cevrilecekler.isNotEmpty) {
      tiklanabilirMi = false;
      liste[tiklanan] = sira;
      update([tiklanan.toString()]);
      Future.delayed(const Duration(seconds: 1), () {
        alinanTaslariCevir();
      });
    } else {
      showInf("Invalid Move");
    }

    // liste[x] = sira;
    // sira = sira == "s" ? "b" : "s";
    // update([x.toString(), "oyunici"]);
  }

  void alinanTaslariCevir() {
    for (var i = 0; i < cevrilecekler.length; i++) {
      Future.delayed(Duration(milliseconds: i * 500), () {
        liste[cevrilecekler[i]] = sira;
        update([cevrilecekler[i].toString()]);

        if (i == cevrilecekler.length - 1) {
          tiklanabilirMi = true;
          sira = sira == "s" ? "b" : "s";
          update(["oyunici"]);
          var rakipHamleYapabilirMi =
              hamleYapilabilirMi.tumKontrollereBasla(sira, liste);
          if (!rakipHamleYapabilirMi) {
            bool bittiMi = !liste.contains("0");
            if (bittiMi) {
              oyunBiterKontrol();
            } else {
              Future.delayed(const Duration(milliseconds: 500), () {
                sira = sira == "s" ? "b" : "s";
                update(["oyunici"]);
                showInf("No valid moves.\nIt's the opponent's turn to move.");
              });
              Future.delayed(const Duration(seconds: 3), () {
                var rakipHamleYapabilirMi =
                    hamleYapilabilirMi.tumKontrollereBasla(sira, liste);
                if (!rakipHamleYapabilirMi) {
                  oyunBiterKontrol();
                }
              });
            }
          } else {
            if (sira == "b") {
              Future.delayed(const Duration(seconds: 2), () {
                aiOynasin();
              });
            }
          }
        }
      });
    }
  }

  void aiOynasin() {
    var secim = aiController.tumKontrollereBasla(sira, liste);
    tiklandi(secim);
  }

  void oyunBiterKontrol() {
    beyazlar = 0;
    siyahlar = 0;
    for (var r in liste) {
      if (r == "s") siyahlar++;
      if (r == "b") beyazlar++;
    }
    if (siyahlar > beyazlar) {
      showInf("Winner : Black");
    } else if (beyazlar > siyahlar) {
      showInf("Winner : White");
    } else {
      showInf("Draw");
    }
    update(["oyunici"]);
  }

  void kendiRengimVarmi(int tiklanan, List<int> kontrolYerleri) {
    for (var k in kontrolYerleri) {
      if (tiklanan - k == 1) {
        solaKontrol(tiklanan);
      } else if (tiklanan - k == -1) {
        sagaKontrol(tiklanan);
      } else if (tiklanan - k == -8) {
        asagiKontrol(tiklanan);
      } else if (tiklanan - k == 8) {
        yukariKontrol(tiklanan);
      } else if (tiklanan - k == -9) {
        sagAsagiKontrol(tiklanan);
      } else if (tiklanan - k == 9) {
        solYukariKontrol(tiklanan);
      } else if (tiklanan - k == -7) {
        solAsagiKontrol(tiklanan);
      } else if (tiklanan - k == 7) {
        sagYukariKontrol(tiklanan);
      }
    }
  }

  void sagYukariKontrol(int tiklanan) {
    int x = tiklanan % 8;
    int y = tiklanan ~/ 8;
    int hedef = -1;
    int kontrol = tiklanan;
    while (true) {
      if (x > 6 || y < 1) {
        break;
      }
      x++;
      y--;

      kontrol = kontrol - 7;
      if (liste[kontrol] == "0") {
        break;
      }

      if (liste[kontrol] == sira) {
        hedef = kontrol;
        break;
      }
    }

    if (hedef != -1) {
      for (var i = tiklanan - 7; i > hedef; i = i - 7) {
        cevrilecekler.add(i);
      }
    }
  }

  void solAsagiKontrol(int tiklanan) {
    int x = tiklanan % 8;
    int y = tiklanan ~/ 8;
    int hedef = -1;
    int kontrol = tiklanan;
    while (true) {
      if (x < 1 || y > 6) {
        break;
      }
      x--;
      y++;
      kontrol = kontrol + 7;
      if (liste[kontrol] == "0") {
        break;
      }
      if (liste[kontrol] == sira) {
        hedef = kontrol;
        break;
      }
    }

    if (hedef != -1) {
      for (var i = tiklanan + 7; i < hedef; i = i + 7) {
        cevrilecekler.add(i);
      }
    }
  }

  void solYukariKontrol(int tiklanan) {
    int x = tiklanan % 8;
    int y = tiklanan ~/ 8;
    int hedef = -1;
    int kontrol = tiklanan;
    while (true) {
      if (x < 1 || y < 1) {
        break;
      }
      x--;
      y--;
      kontrol = kontrol - 9;
      if (liste[kontrol] == "0") {
        break;
      }
      if (liste[kontrol] == sira) {
        hedef = kontrol;
        break;
      }
    }

    if (hedef != -1) {
      for (var i = tiklanan - 9; i > hedef; i = i - 9) {
        cevrilecekler.add(i);
      }
    }
  }

  void sagAsagiKontrol(int tiklanan) {
    int x = tiklanan % 8;
    int y = tiklanan ~/ 8;
    int hedef = -1;
    int kontrol = tiklanan;
    while (true) {
      if (x > 6 || y > 6) {
        break;
      }
      x++;
      y++;
      kontrol = kontrol + 9;

      if (liste[kontrol] == "0") {
        break;
      }
      if (liste[kontrol] == sira) {
        hedef = kontrol;
        break;
      }
    }
    if (hedef != -1) {
      for (var i = tiklanan + 9; i < hedef; i = i + 9) {
        cevrilecekler.add(i);
      }
    }
  }

  void yukariKontrol(int tiklanan) {
    int x = tiklanan % 8;
    int y = tiklanan ~/ 8;
    int hedef = -1;
    if (y > 1) {
      for (var i = y - 2; i > -1; i--) {
        if (liste[i * 8 + x] == "0") {
          break;
        }
        if (liste[i * 8 + x] == sira) {
          hedef = i * 8 + x;
          break;
        }
      }
    }
    if (hedef != -1) {
      for (var i = tiklanan - 8; i > hedef; i = i - 8) {
        cevrilecekler.add(i);
      }
    }
  }

  void asagiKontrol(int tiklanan) {
    int x = tiklanan % 8;
    int y = tiklanan ~/ 8;
    int hedef = -1;
    if (y < 6) {
      for (var i = y + 2; i < 8; i++) {
        if (liste[i * 8 + x] == "0") {
          break;
        }
        if (liste[i * 8 + x] == sira) {
          hedef = i * 8 + x;
          break;
        }
      }
    }

    if (hedef != -1) {
      for (var i = tiklanan + 8; i < hedef; i = i + 8) {
        cevrilecekler.add(i);
      }
    }
  }

  void sagaKontrol(int tiklanan) {
    int x = tiklanan % 8;
    int y = tiklanan ~/ 8;
    int hedef = -1;

    if (x < 6) {
      for (var i = x + 2; i < 8; i++) {
        if (liste[y * 8 + i] == "0") {
          break;
        }
        if (liste[y * 8 + i] == sira) {
          hedef = y * 8 + i;
          break;
        }
      }
    }

    if (hedef != -1) {
      for (var i = tiklanan + 1; i < hedef; i++) {
        cevrilecekler.add(i);
      }
    }
  }

  void solaKontrol(int tiklanan) {
    int x = tiklanan % 8;
    int y = tiklanan ~/ 8;
    int hedef = -1;
    if (x > 1) {
      for (var i = x - 2; i > -1; i--) {
        if (liste[y * 8 + i] == "0") {
          break;
        }
        if (liste[y * 8 + i] == sira) {
          hedef = y * 8 + i;
          break;
        }
      }
    }
    if (hedef != -1) {
      for (var i = tiklanan - 1; i > hedef; i--) {
        cevrilecekler.add(i);
      }
    }
  }

  List<int> farkliRenktemi(int x) {
    List<int> yanTaraflar = [];

    if (x % 8 != 0) {
      yanTaraflar.add(x - 1);
      if ((x - 9) > -1) yanTaraflar.add(x - 9);
      if ((x + 7) < 64) yanTaraflar.add(x + 7);
    }
    if ((x + 1) % 8 != 0) {
      yanTaraflar.add(x + 1);
      if ((x - 7) > -1) yanTaraflar.add(x - 7);
      if ((x + 9) < 64) yanTaraflar.add(x + 9);
    }
    if (x < 56) yanTaraflar.add(x + 8);
    if (x > 7) yanTaraflar.add(x - 8);
    String kontrolEdilecekRenk = sira == "s" ? "b" : "s";
    List<int> farkliRenktekiYerler = [];
    for (int i in yanTaraflar) {
      if (liste[i] == kontrolEdilecekRenk) {
        farkliRenktekiYerler.add(i);
      }
    }

    return farkliRenktekiYerler;
  }

  int siyahSayisi() {
    int siyah = 0;
    for (var r in liste) {
      if (r == "s") {
        siyah++;
      }
    }
    return siyah;
  }

  int beyazSayisi() {
    int beyaz = 0;
    for (var r in liste) {
      if (r == "b") {
        beyaz++;
      }
    }
    return beyaz;
  }

  void tekrarOyna() {
    List.generate(64, (index) {
      Future.delayed(Duration(milliseconds: index * 50), () {
        liste[index] = "0";
        update(['$index']);
      });
    });
    Future.delayed(const Duration(milliseconds: 3500), () {
      hazirlik();
      update(['oyunici', '27', '28', '35', '36']);
    });
  }
}

class AiController {
  late String sira;
  late List<String> liste;
  List<int> cevrilecekler = [];
  Map<int, List<int>> kacTaneVar = {};
  List<int> koseler = [0, 7, 56, 63];
  List<int> kenarlar = [
    1,
    2,
    3,
    4,
    5,
    6,
    15,
    23,
    31,
    39,
    47,
    55,
    8,
    16,
    24,
    32,
    40,
    48,
    56,
    57,
    58,
    59,
    60,
    61,
    62
  ];

  int tumKontrollereBasla(String s, List<String> l) {
    kacTaneVar = {};
    sira = s;
    liste = l;

    for (var i = 0; i < liste.length; i++) {
      if (liste[i] == "0") {
        cevrilecekler = [];
        tiklandi(i);
        if (cevrilecekler.isNotEmpty) {
          kacTaneVar[i] = cevrilecekler;
        }
      }
    }
    int toplamcevrilebilir = 0;
    int secim = -1;
    for (var key in kacTaneVar.keys) {
      List<int>? value = kacTaneVar[key];
      if (value!.length > toplamcevrilebilir) {
        if (koseler.contains(key)) {
          return key;
        } else if (kenarlar.contains(key)) {
          return key;
        } else {
          toplamcevrilebilir = value.length;
          secim = key;
        }
      }
    }

    return secim;
  }

  void tiklandi(int tiklanan) {
    var kontrolYerleri = farkliRenktemi(tiklanan);

    if (kontrolYerleri.isNotEmpty) {
      kendiRengimVarmi(tiklanan, kontrolYerleri);
    }
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
    if (cevrilecekler.isNotEmpty) {
      kacTaneVar[tiklanan] = cevrilecekler;
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
    if (cevrilecekler.isNotEmpty) {
      kacTaneVar[tiklanan] = cevrilecekler;
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
    if (cevrilecekler.isNotEmpty) {
      kacTaneVar[tiklanan] = cevrilecekler;
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
    if (cevrilecekler.isNotEmpty) {
      kacTaneVar[tiklanan] = cevrilecekler;
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
    if (cevrilecekler.isNotEmpty) {
      kacTaneVar[tiklanan] = cevrilecekler;
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
    if (cevrilecekler.isNotEmpty) {
      kacTaneVar[tiklanan] = cevrilecekler;
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
    if (cevrilecekler.isNotEmpty) {
      kacTaneVar[tiklanan] = cevrilecekler;
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
      for (var i = hedef + 1; i < tiklanan; i++) {
        cevrilecekler.add(i);
      }
    }
    if (cevrilecekler.isNotEmpty) {
      kacTaneVar[tiklanan] = cevrilecekler;
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
}

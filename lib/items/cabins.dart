//========================================
//Class untuk Objek Kabin, karna gapande
//JSON yaudah langsung assign aja
//========================================

import 'dart:collection';

class Cabins{
  HashMap cabin = new HashMap<String, String>();
  Cabins(){
    cabin['Y'] = 'Economy Class';
    cabin['F'] = 'First Class';
    cabin['J'] = 'Business Class';
  }
}
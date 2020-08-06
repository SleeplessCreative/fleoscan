//=========================================
//Class untuk Objek maskapai, karna gapande
//JSON yaudah langsung assign aja
//=========================================

import 'dart:collection';

class Airlines{
  HashMap airline = new HashMap<String, String>();
  Airlines(){
    airline['ID'] = 'Batik Air';
    airline['QG'] = 'Citilink Airlines';
    airline['GA'] = 'Garuda Indonesia';
    airline['QZ'] = 'Indonesia AirAsia';
    airline['KD'] = 'PT Kal Star Aviation';
    airline['JT'] = 'Lion Air';
    airline['IN'] = 'NAM Air';
    airline['SJ'] = 'Sriwijaya Air';
    airline['IW'] = 'Wings Air';
    airline['SI'] = 'Susi Air';
  }
}
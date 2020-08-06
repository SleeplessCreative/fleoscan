//===========================================
//Class untuk Objek nama bulan, karna gapande
//JSON yaudah langsung assign aja
//===========================================
import 'dart:collection';

class Months{
  HashMap month = new HashMap<int, String>();
  Months(){
    month[0] = '';
    month[1] = 'Januari';
    month[2] = 'Februari';
    month[3] = 'Maret';
    month[4] = 'April';
    month[5] = 'Mei';
    month[6] = 'Juni';
    month[7] = 'Juli';
    month[8] = 'Agustus';
    month[9] = 'September';
    month[10] = 'Oktober';
    month[11] = 'November';
    month[12] = 'Desember';
  }
}
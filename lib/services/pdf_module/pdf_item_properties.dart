import 'package:pdf/pdf.dart';

class PdfItemProperties {
  getOddRowColor() {
    return PdfColor.fromInt(0xD9D9D9);
  }

  getEvenRowColor() {
    return PdfColor.fromInt(0xF2F2F2);
  }

  getHeaderColor(String code) {
    switch (code) {
      case 'GA':
        return PdfColor.fromInt(0x9CC2E5);
        break;
      case 'ID':
        return PdfColor.fromInt(0xBF2654);
        break;
      case 'IN':
        return PdfColor.fromInt(0xFF0000);
        break;
      case 'IW':
        return PdfColor.fromInt(0xEC2028);
        break;
      case 'JT':
        return PdfColor.fromInt(0xEC1B2A);
        break;
      case 'KD':
        return PdfColor.fromInt(0x1D49AA);
        break;
      case 'QG':
        return PdfColor.fromInt(0x0C803D);
        break;
      case 'QZ':
        return PdfColor.fromInt(0xE32526);
        break;
      case 'SI':
        return PdfColor.fromInt(0x291770);
        break;
      case 'SJ':
        return PdfColor.fromInt(0xCAA767);
        break;
      default:
        return PdfColor.fromInt(0x767171);
        break;
    }
  }
}

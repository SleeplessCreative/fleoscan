//================================
//Class warna, lumayan berguna lah
//ada anunya juga, apatu efek bayangan gitu
//================================

import 'package:flutter/material.dart';

class FleoColor {
  static Color c100() {
    return const Color(0xFFFBCD15);
  }

  static Color c200() {
    return const Color(0xFFFFFFFF);
  }

  static Color c300() {
    return const Color(0xFFF8F8F8);
  }

  static Color c400() {
    return const Color(0xFF696969);
  }

  static Color c500() {
    return const Color(0xFF95B2CC);
  }

  static Color c600() {
    return const Color(0xFF5998CF);
  }

  static Color c700() {
    return const Color(0xFF238823);
  }

  static Color c800() {
    return const Color(0xFFD2222D);
  }
}

const defaultShadow = BoxShadow(
  offset: Offset(0, -5),
  blurRadius: 69,
  color: Colors.black12,
);

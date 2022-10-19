import 'package:flutter/material.dart';

class AppColors {
  static Color get kScaffold => const Color(0xFF262626);
  static Color get kPrimary => const Color(0xFF5ECE9A);
  static Color get kPrimary500 => const Color(0xFF059E53);
  static Color get kDark => const Color(0xFF111418);
  static Color get kError => const Color(0xFFFE1B02);
  static Color get kGrey => const Color(0xFFB7C7CD);
  static Color get kGrey200 => const Color(0xFFE2E7EF);
}

const List<Color> iconColors = [
  Colors.teal,
  Colors.blueGrey,
  Colors.purpleAccent,
  Colors.green,
  Colors.deepOrangeAccent
];

class Fonts {
  static const kPrimary = "Inter";
}

class Insets {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 32;
}

class Corners {
  static const Radius smRadius = Radius.circular(Insets.sm);
  static const BorderRadius smBorder = BorderRadius.all(smRadius);

  static const Radius mdRadius = Radius.circular(Insets.md);
  static const BorderRadius mdBorder = BorderRadius.all(mdRadius);

  static const Radius lgRadius = Radius.circular(Insets.lg);
  static const BorderRadius lgBorder = BorderRadius.all(lgRadius);

  static const Radius xlRadius = Radius.circular(50);
  static const BorderRadius xlBorder = BorderRadius.all(xlRadius);
}

class FontSizes {
  static const double s8 = 8;
  static const double s10 = 10;
  static const double s12 = 12;
  static const double s14 = 14;
  static const double s16 = 16;
  static const double s18 = 18;
  static const double s20 = 20;
  static const double s24 = 24;
  static const double s28 = 28;
  static const double s32 = 32;
  static const double s36 = 36;
  static const double s48 = 48;
}

class Sizes {
  static const double s2 = 2;
  static const double s4 = 4;
  static const double s8 = 8;
  static const double s10 = 10;
  static const double s12 = 12;
  static const double s14 = 14;
  static const double s16 = 16;
  static const double s18 = 18;
  static const double s20 = 20;
  static const double s24 = 24;
  static const double s28 = 28;
  static const double s32 = 32;
  static const double s36 = 36;
  static const double s48 = 48;
}

class IconSizes {
  static const double sm = 18;
  static const double md = 24;
  static const double lg = 32;
}

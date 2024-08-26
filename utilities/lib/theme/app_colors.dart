import 'package:flutter/material.dart';

class AppColors {
  static const Color alabaster = Color(0xFFF9FAFC);
  static const Color white = Color(0xFFFFFFFF);
  static const Color backgroundColor = Color(0xFFF4F7FE);
  static const Color desertStorm = Color(0xFFF7F8F9);
  static const Color whiteSmoke = Color(0xFFF3F6F9);
  static const Color softPeach = Color(0xFFEDEDED);
  static const Color magnolia = Color(0xFFF6F6FB);
  static const Color heather = Color(0xFFBCC1CD);
  static const whiteFrost = Color(0xffD9E7FF);

  // Medium Shades
  static const Color frenchGrey = Color(0xFFB9BCC8);
  static const Color iron = Color(0xFFD0D5DD);
  static const Color paleSky = Color(0xFF6E717C);
  static const Color stormGrey = Color(0xFF697386);

  // Dark Shades
  static const Color black = Color(0xFF000000);
  static const Color darkJungleGreen = Color(0xFF1D1D1D);
  static const Color black04 = Color(0x0A1D1D1D);
  static const Color balticSea = Color(0xFF292D32);
  static const Color stormDust = Color(0xFF5E6366);
  static const Color paleSky30 = Color(0x4D6E717C); //30% opacity
  static const Color boulder = Color(0xFF747579); // Adding Boulder

  // Scaffold Snackbar

  static const hintOfGreen = Color(0xFFDFFFE6);
  static const shareGreen = Color(0xff137333);
  static const red = Color(0xffE40721);
  static const bgRed = Color(0xffFEF0F0);
  static const yellow = Color(0xffF1A731);
  static const bgYellow = Color(0xffFFF8EC);
  static const redBg = Color(0xffFFDEDE);

  // CADMIUM RED
  static const Color cadmiumRed = Color(0xFFD80027);

  static const Color mediumSeaGreen = Color(0xFF4EB570);

  static const Color swamp = Color(0xFF668744);
  static const Color atlantis = Color(0xFF89DA36);
  static const Color seaGreen = Color(0xFF208A43);
  static const Color darkMintGreen = Color(0xFF00C853);
  static const Color fernGreen = Color(0xFF578B3C);

  static const Color mediumTealBlue = Color(0xFF055AAB);
  static const Color blueKoi = Color(0xFF699FD2);
  static const Color primaryColor = Color(0xFF066AC9);
  static const Color ultramarineBlue = Color(0xFF5570F1);
  static const Color blueHaze = Color(0xFFB6C2E2);

  static const Color brightGold = Color(0xFFFFD220);

// IELTS Dashboard
  static const Color lightSlateBlue = Color(0xFF686BFF);
  static const Color blueBell = Color(0xFF98A3C7);
  static const Color blueBayoux = Color(0xFF525F7F);
  static const Color nobel = Color(0xFFB1B1B5);
  static const Color gainsBoro = Color(0xFFDCDCDD);
  static const Color blackPearl = Color(0xFF0A171B);
  static const Color portLangOrange = Color(0xFFFF512F);
  static const Color papayaOrange = Color(0xFFF3601E);
  static const Color gamboge = Color(0xFFF09819);
  static const Color brightSun = Color(0xFFFFCD45);
  static const Color golden = Color(0xFFF1C100);
  static const Color gunMetal = Color(0xFF2B3340);
  static const Color chardonnay = Color(0xFFFFCC91);
  static const Color mistBlue = Color(0xFF6E7079);
  static const Color yellowyGreen = Color(0xFFB0F41F);
  static const Color periwinkle = Color(0xFFCDC8FF);
  static const Color brightGrey = Color(0xFF374151);
  static const Color blueGrey = Color(0xFF64748B);
  static const Color vistaWhite = Color(0xFFFAF9F9);
  static const Color paleAqua = Color(0xFFB6D3EF);

  static const smokeGrey50 = Color(0x80747474);
  static const textGrey = Color(0xff747474);
// GUEST Dashboard
  static const Color saffronMango = Color(0xFFFFBF43);
  static const Color yellowOchre = Color(0xFFCC9900);
  static const Color goldenYellow = Color(0xFFFFDF00);
  static const Color jasmine = Color(0xFFFBDB89);
  static const Color tan = Color(0xFFCDB26E);
  static const Color astra = Color(0xFFFFEAB7);
  static const Color marineBlue = Color(0xFF002F5B);
  static const Color carolinaBlue = Color(0xFF99BCDE);
  static const Color darkGrey = Color(0xFF393939);
  static const Color coralBlue = Color(0xFFB4D6F6);
  static const Color cadetGrey = Color(0xFF94A3B8);

  static const Color onyx = Color(0xFF111111);

//   Study Abroad
  static const Color aluminium = Color(0xFFABAFB1);
  static const Color asparagus = Color(0xFF73A35A);
  static const Color whiteLilac = Color(0xFFF5F7FC);
  static const Color leaf = Color(0xFF7F9C34);
  static const subtitle = Color(0xFF747579);
  static const cardColor = Color(0xffF5F7F9);
  static const receiverColor = Color(0xFFFFEAD1);
  static const platinum = Color(0xFFE1E2E9);
  static const osloGrey = Color(0xFF8B8D97);
  static const butterflyBlue = Color(0xFF27AAF4);
  static const greenishCyan = Color(0xFF16C886);
  static const jewel = Color(0xFF0A634B);
  static const mangoOrange = Color(0xFFFF7D43);
  static const jasper = Color(0xFFE13D3D);
}

class GradientAppColors {
  static const Gradient goldenGradient = LinearGradient(
    colors: [
      AppColors.goldenYellow,
      AppColors.yellowOchre,
    ],
  );

  static const Gradient resultGradient = LinearGradient(
    colors: [
      AppColors.mediumTealBlue,
      AppColors.blueKoi,
    ],
  );

  static const Gradient courseFinderCardGradient = LinearGradient(
    colors: [
      AppColors.butterflyBlue,
      AppColors.greenishCyan,
    ],
  );
}

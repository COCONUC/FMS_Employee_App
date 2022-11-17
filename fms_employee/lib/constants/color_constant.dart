import 'package:flutter/material.dart';
import 'dart:ui';

const mBackgroundColor = Color(0xDCF5ECEC);
const mBlueColor = Color(0xFF2C53B1);
const mGreyColor = Color(0xD3A19D9D);
const mTitleColor = Color(0xFF23374D);
const mSubtitleColor = Color(0xFF8E8E8E);
const mFillColor = Color(0x7EFFFFFF);
const mCardTitleColor = Color(0xFF2E4ECF);
const mCardSubtitleColor = Color(0xFFC93956);
const mBorderColor = Color(0xFFE8E8F3);
const mSecondaryColor = Color(0xFFD96914);
const mTextColorSecondary = Color(0xFF747474);
const mBoxColor = Color(0xE9E7C5B1);
Color backGroundColor = "#F9FAFC".toColor();
Color blueColor = "#23408F".toColor();
Color intro1Color = "#FFC8CF".toColor();
Color intro2Color = "#E5ECFF".toColor();
Color intro3Color = "#F7FBCD".toColor();
Color dividerColor = "#E5E8F1".toColor();
Color textColor = "#6E758A".toColor();
Color deatilColor = "#D3DFFF".toColor();
Color listColor = "#EEF1F9".toColor();
Color procced = "#E2EAFF".toColor();
Color success = "#04B155".toColor();
Color completed = "#0085FF".toColor();
Color error = "#FF2323".toColor();
Color blueShadow = "#C8CFE2".toColor();
Color receiverColor = "#E8EEFF".toColor();

extension ColorExtension on String {
  toColor() {
    var hexColor = replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}
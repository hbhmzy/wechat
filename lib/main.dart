import 'package:flutter/material.dart';
import 'package:flutter_apptest/home/home_screen.dart';
import 'package:flutter_apptest/constants.dart' show AppColors;
void main() => runApp(new MaterialApp(
  title:'微信—clone',
  theme: ThemeData.light().copyWith(
    primaryColor: Color(AppColors.AppBarColor),
    cardColor: const Color(AppColors.CardBgColor),
  ),
  home: HomeScreen(),
));





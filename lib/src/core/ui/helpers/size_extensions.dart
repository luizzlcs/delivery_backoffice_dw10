import 'package:flutter/material.dart';

extension SizeExtensions on BuildContext{ 
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  double get screenShortestSide => MediaQuery.of(this).size.shortestSide; // Pega menor tamanho da tela.
  double get screenSlongestSide => MediaQuery.of(this).size.longestSide; // Pega o maior tamanho da tela.

  double percentWidth(double percent) =>  screenWidth * percent;
  double percentHeight(double percent) =>  screenHeight * percent;

}
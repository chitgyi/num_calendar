import 'package:flutter/material.dart';

extension ContextX on BuildContext {
  double get cellWidth {
    final parentWidth = MediaQuery.sizeOf(this).width - 32.0 - 28;
    final cellWidth = parentWidth / 8;
    return cellWidth;
  }
}

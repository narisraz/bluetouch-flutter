import 'package:flutter/cupertino.dart';

class ResponsiveUtils {
  static bool isMobile(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return width < 600;
  }
}

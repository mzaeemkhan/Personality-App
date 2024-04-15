import 'package:flutter/cupertino.dart';
Widget customIcon(IconData icon,double size,color) {
  return Icon(
    icon,
    size: size,
    color: color,
  );
}
Widget customAssetsIcon(String icon,double size ,color) {
  return ImageIcon(
      AssetImage(icon),
      color: color,
      size:size
  );
}
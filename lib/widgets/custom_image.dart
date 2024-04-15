import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget assetImage(String image) {
  return Image.asset(image,fit: BoxFit.fill,);
}

Widget logoImage(String image, int height, int width) {
  return Image.asset(image, cacheHeight: height, cacheWidth: width,fit: BoxFit.cover,);
}

Widget customImage(String image, double height, double width) {
  return Image.asset(
    image,
    height: height,
    width: width,
    fit: BoxFit.fill,
  );
}

Widget svgImage(String image) {
  return SvgPicture.asset(image);
}

Widget customSvgImage(String image, double height, double width) {
  return  SvgPicture.asset(
      image,
      height: height,
      width: width,
      semanticsLabel: image,
      placeholderBuilder: (BuildContext context) =>
          Container(
            padding: const EdgeInsets.all(30.0),
          )
  );

}

Widget heightSvgImage(String image, double height) {
  return SvgPicture.asset(image, height: height);
}

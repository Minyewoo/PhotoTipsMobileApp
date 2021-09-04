import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialCircle extends StatelessWidget {
  final String iconPath;
  final Function pressAction;
  const SocialCircle({
    Key key,
    this.iconPath,
    this.pressAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: pressAction,
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          padding: EdgeInsets.all(12),
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Color(0xfff5f6f9),
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(iconPath)),
    );
  }
}

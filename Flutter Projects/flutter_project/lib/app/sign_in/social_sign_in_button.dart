import 'package:flutter/material.dart';

import '../common_widgets/custom_elevated_button.dart';

class SocialSignInButton extends CustomElevatedButton{
  SocialSignInButton({
    super.key,
    required String assetName,
    required String text,
    required Color? color,
    required double height,
    required Color textColor,
    required VoidCallback onPressed
  }) : super(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Image.asset(assetName),
        Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 15.0
          ),
        ),
        Opacity(
          opacity: 0.0,
          child: Image.asset(assetName),
        ),
      ]
    ),
    color: color,
    onPressed: onPressed,
    borderRadius: 4.0,
    height: height
  );
}
import 'package:buying/consts/styles.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget ourButton({onpressed, color, textColor, String? title}) {
  return ElevatedButton(
      style:
      ElevatedButton.styleFrom(primary: color, padding: EdgeInsets.all(12)),
      onPressed: onpressed,
      child: title!.text.color(textColor).white.fontFamily(bold).make());
}

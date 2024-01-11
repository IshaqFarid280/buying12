
import 'package:buying/consts/colors.dart';
import 'package:buying/consts/styles.dart';
import 'package:buying/widget/our_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';

Widget exitDialog(context) {
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Confirm".text.fontFamily(bold).size(18).color(darkFontGrey).make(),
        Divider(),
        10.heightBox,
        "Are u sure want to exit?".text.size(16).make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ourButton(color: redColor, onpressed: (){
              SystemNavigator.pop();
            }, textColor: whiteColor, title: "Yes"),

            ourButton(color: redColor, onpressed: (){
              Navigator.pop(context);
            }, textColor: whiteColor, title: "No"),
          ],
        )
      ],
    ).box.color(lightGrey).padding(EdgeInsets.all(12)).roundedSM.make(),
  );
}

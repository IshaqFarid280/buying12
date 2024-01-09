import 'package:admin_panel/consts/colors.dart';
import 'package:admin_panel/reusable_widgets/text_widgets.dart';
import 'package:flutter/material.dart';



class CustomButton extends StatelessWidget {
  final String title ;
  final VoidCallback onTap ;
  final double width ;
  const CustomButton({required this.title, required this.onTap,this.width = 0.7});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius:BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: buttonColors,
        ),
        width: MediaQuery.sizeOf(context).width * width,
        height:MediaQuery.sizeOf(context).height * 0.04,
        child: Center(
          child: normalText(title: title),
        ),
      ),
    );
  }
}

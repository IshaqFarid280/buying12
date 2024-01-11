
import 'package:buying/consts/colors.dart';
import 'package:flutter/material.dart';

class CustomTextFeild extends StatelessWidget {
  final TextEditingController controller ;
  final String hintText ;
   CustomTextFeild({required this.controller,required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style:const  TextStyle(color: whiteColor),
      cursorColor: buttonColors,
      enabled: true,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle:const TextStyle(color: iconColor),
        border: OutlineInputBorder(
          borderSide:const BorderSide(color:iconColor),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder:OutlineInputBorder(
          borderSide:const BorderSide(color:iconColor,),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:const BorderSide(color:iconColor,width: 3),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

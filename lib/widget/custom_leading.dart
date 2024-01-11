
import 'package:buying/consts/colors.dart';
import 'package:flutter/material.dart';

class CustomLeading extends StatelessWidget {
  const CustomLeading({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){ Navigator.pop(context); },
      child: Container(
        margin: const EdgeInsets.all(6),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: listTileColor,
        ),
        child:const Center(child: Icon(Icons.arrow_back_ios_new,),),
      ),
    );
  }
}

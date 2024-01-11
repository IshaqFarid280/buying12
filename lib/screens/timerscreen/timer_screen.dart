import 'package:buying/consts/colors.dart';
import 'package:buying/widget/textwidgets.dart';
import 'package:flutter/material.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        backgroundColor: blackColor,
        title: largeText(title: 'Timer Screen', color: blackColor),
      ),

    );
  }
}

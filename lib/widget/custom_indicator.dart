
import 'package:buying/consts/colors.dart';
import 'package:flutter/material.dart';

class CustomIndicator extends StatelessWidget {
  const CustomIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: buttonColors,
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'height_screen.dart';

class GenderSelectionScreen extends StatelessWidget {
  final int userId;
  GenderSelectionScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Gender'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GenderBox(
              gender: 'Male',
              onTap: () {
                _navigateToNextScreen(context, 'Male',userId);
              },
            ),
            GenderBox(
              gender: 'Female',
              onTap: () {
                _navigateToNextScreen(context, 'Female',userId);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToNextScreen(BuildContext context, String selectedGender,userId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HeightScreen(userId:userId,gender:selectedGender),
      ),
    );
  }
}

class GenderBox extends StatelessWidget {
  final String gender;
  final VoidCallback onTap;

  GenderBox({required this.gender, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 100,
        color: Colors.blue,
        child: Center(
          child: Text(
            gender,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
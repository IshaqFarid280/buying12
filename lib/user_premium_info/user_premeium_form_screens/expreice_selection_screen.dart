import 'package:flutter/material.dart';

import '../user_premium_info_screen.dart';
import 'equipmint_screen.dart';

class ExperienceSelectionScreen extends StatefulWidget {
  final int userId;
  final double height;
  final String gender;
  final double weight;
  final int age;
  final List<String> goals;
  ExperienceSelectionScreen(
      {required this.userId,
      required this.height,
      required this.weight,
      required this.gender,
      required this.age,
      required this.goals});

  @override
  _ExperienceSelectionScreenState createState() =>
      _ExperienceSelectionScreenState();
}

class _ExperienceSelectionScreenState extends State<ExperienceSelectionScreen> {
  String selectedExperience = ''; // Initially no experience selected

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Experience'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildExperienceBox('Amateur'),
            buildExperienceBox('Intermediate'),
            buildExperienceBox('Expert'),
            buildExperienceBox('Professional'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the next screen with the selected experience
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EquipmentSelectionScreen(
                      userId: widget.userId,
                      height: widget.height,
                      weight: widget.weight,
                      gender: widget.gender,
                      age: widget.age,
                      goals: widget.goals,
                      experience: selectedExperience,
                    ),
                  ),
                );
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildExperienceBox(String experience) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedExperience = experience;
        });
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.0),
        margin: EdgeInsets.only(bottom: 16.0),
        decoration: BoxDecoration(
          color: selectedExperience == experience
              ? Colors.blue // Change the color as per your preference
              : Colors.grey,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            experience,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
        ),
      ),
    );
  }
}

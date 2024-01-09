import 'package:buying/user_premium_info/user_premeium_form_screens/interest_selection_screen.dart';
import 'package:flutter/material.dart';

class EquipmentSelectionScreen extends StatefulWidget {
  final int userId;
  final double height;
  final String gender;
  final double weight;
  final int age;
  final List<String> goals;
  String experience ;

  EquipmentSelectionScreen({
    required this.userId,
    required this.height,
    required this.weight,
    required this.gender,
    required this.age,
    required this.goals,
    required this.experience,
  });

  @override
  _EquipmentSelectionScreenState createState() =>
      _EquipmentSelectionScreenState();
}

class _EquipmentSelectionScreenState extends State<EquipmentSelectionScreen> {
  String selectedEquipment = ''; // Initially no equipment selected

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Equipment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildEquipmentOption('Dumbbell'),
            buildEquipmentOption('Gym Machine'),
            buildEquipmentOption('Resistance Bands'),
            buildEquipmentOption('Bodyweight Exercises'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the next screen with the selected equipment
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InterestSelectionScreen(
                      userId: widget.userId,
                      height: widget.height,
                      weight: widget.weight,
                      gender: widget.gender,
                      age: widget.age,
                      equipment: selectedEquipment,
                      experience: widget.experience,
                      goals: widget.goals,
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

  Widget buildEquipmentOption(String equipment) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedEquipment = equipment;
        });
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.0),
        margin: EdgeInsets.only(bottom: 16.0),
        decoration: BoxDecoration(
          color: selectedEquipment == equipment
              ? Colors.blue // Change the color as per your preference
              : Colors.grey,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            equipment,
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
import 'package:buying/user_premium_info/user_premium_info_screen.dart';
import 'package:flutter/material.dart';

class FocusSelectionScreen extends StatefulWidget {
  final int userId;
  final double height;
  final String gender;
  final double weight;
  final int age;
  final List<String> goals;
  final String experience;
  final String equipment;
  final List<String> interests;

  FocusSelectionScreen({
    required this.userId,
    required this.height,
    required this.weight,
    required this.gender,
    required this.age,
    required this.goals,
    required this.experience,
    required this.equipment,
    required this.interests
  });

  @override
  _FocusSelectionScreenState createState() => _FocusSelectionScreenState();
}

class _FocusSelectionScreenState extends State<FocusSelectionScreen> {
  List<String> selectedFocus = [];

  final List<String> allFocus = [
    'Chest',
    'Legs',
    'Arms',
    'Back',
    // Add more focus options as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Focus'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: List.generate(
                allFocus.length,
                    (index) => ChoiceChip(
                  label: Text(allFocus[index]),
                  selected: selectedFocus.contains(allFocus[index]),
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        selectedFocus.add(allFocus[index]);
                      } else {
                        selectedFocus.remove(allFocus[index]);
                      }
                    });
                  },
                  selectedColor: Colors.green, // Change the color as per your preference
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the next screen with the selected focus options
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserFromScreen(
                      userId: widget.userId,
                      height: widget.height,
                      weight: widget.weight,
                      gender: widget.gender,
                      age: widget.age,
                      focus: selectedFocus,
                      experience: widget.experience,
                      equipment: widget.equipment,
                      goals: widget.goals,
                      interests: widget.interests,
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
}

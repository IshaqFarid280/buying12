import 'package:buying/user_premium_info/user_premeium_form_screens/fous_selection_screen.dart';
import 'package:flutter/material.dart';

class InterestSelectionScreen extends StatefulWidget {
  final int userId;
  final double height;
  final String gender;
  final double weight;
  final int age;
  final List<String> goals ;
  final String experience ;
  final String equipment;

  InterestSelectionScreen({
    required this.userId,
    required this.height,
    required this.weight,
    required this.gender,
    required this.age,
    required this.experience,
    required this.equipment,
    required this.goals
  });

  @override
  _InterestSelectionScreenState createState() =>
      _InterestSelectionScreenState();
}

class _InterestSelectionScreenState extends State<InterestSelectionScreen> {
  List<String> selectedInterests = [];

  final List<String> allInterests = [
    'Muscles',
    'Packs',
    'Endurance',
    // Add more interests as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Interests'),
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
                allInterests.length,
                    (index) => ChoiceChip(
                  label: Text(allInterests[index]),
                  selected: selectedInterests.contains(allInterests[index]),
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        selectedInterests.add(allInterests[index]);
                      } else {
                        selectedInterests.remove(allInterests[index]);
                      }
                    });
                  },
                  selectedColor: Colors.blue, // Change the color as per your preference
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the next screen with the selected interests
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FocusSelectionScreen(
                      userId: widget.userId,
                      height: widget.height,
                      weight: widget.weight,
                      gender: widget.gender,
                      age: widget.age,
                      interests: selectedInterests,
                      goals: widget.goals,
                      experience: widget.experience,
                      equipment: widget.equipment,
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
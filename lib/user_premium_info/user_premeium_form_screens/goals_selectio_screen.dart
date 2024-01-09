import 'package:flutter/material.dart';
import 'expreice_selection_screen.dart';

class GoalSelectionScreen extends StatefulWidget {
  final int userId ;
  final double height ;
  final String gender ;
  final double weight ;
  final int age ;
  GoalSelectionScreen({required this.userId,required this.height,required this.weight,required this.gender,required this.age});
  @override
  _GoalSelectionScreenState createState() => _GoalSelectionScreenState();
}

class _GoalSelectionScreenState extends State<GoalSelectionScreen> {
  List<String> selectedGoals = [];

  final List<String> allGoals = [
    'Keep Healthy',
    'Running',
    'Body Weight',
    'Legs Power',
    // Add more goals as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Goals'),
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
                allGoals.length,
                    (index) => ChoiceChip(
                      label: Text(allGoals[index]),
                      selected: selectedGoals.contains(allGoals[index]),
                      selectedColor: Colors.blue, // Change the color as per your preference
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            selectedGoals.add(allGoals[index]);
                          } else {
                            selectedGoals.remove(allGoals[index]);
                          }
                        });
                      },
                    ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the next screen with the selected goals
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExperienceSelectionScreen(userId: widget.userId,height: widget.height,weight: widget.weight,gender: widget.gender,age: widget.age,goals: selectedGoals,),
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
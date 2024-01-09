import 'package:buying/user_premium_info/user_premeium_form_screens/weight_screen.dart';
import 'package:flutter/material.dart';


class HeightScreen extends StatefulWidget {
  final int userId;
  final String gender ;
  HeightScreen({required this.userId,required this.gender,});

  @override
  _HeightScreenState createState() => _HeightScreenState();
}

class _HeightScreenState extends State<HeightScreen> {
  double height = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Height'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Row containing Image and Slider
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image with dynamic height based on the slider value
                Container(
                  height: 150.0 + height,
                  child: Image.asset(
                    'assets/images/body.jpeg',
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(width: 20), // Adjust the spacing between Image and Slider
                // Slider without custom appearance
                RotatedBox(
                  quarterTurns: 3,
                  child: Slider(
                    value: height,
                    min: 0.0,
                    max: 300.0, // Maximum height set to 300 cm
                    onChanged: (value) {
                      setState(() {
                        height = value;
                      });
                    },
                    label: height.toStringAsFixed(2), // Display current height in the slider label
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Display current height
            Text(
              'Height: ${height.toStringAsFixed(2)} cm',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the next screen with user ID and height
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WeightScreen(userId: widget.userId, height: height,gender: widget.gender,),
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




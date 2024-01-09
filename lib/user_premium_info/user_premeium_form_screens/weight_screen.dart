import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'age_screen.dart';

class WeightScreen extends StatefulWidget {
  final int userId ;
  final double height ;
  final String gender ;
  WeightScreen({required this.userId,required this.height,required this.gender,});
  @override
  _WeightScreenState createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> {
  int selectedWholeNumber = 70; // Default whole number
  int selectedDecimal = 0; // Default decimal

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Weight'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildWholeNumberPicker(),
                SizedBox(width: 20),
                buildDecimalPicker(),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Combine selected values to create the final weight
                double selectedWeight = selectedWholeNumber +
                    selectedDecimal * 0.1;
                print(selectedWeight);
                // Navigate to the next screen with the selected weight
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AgeSelectionScreen(
                          userId: widget.userId, height: widget.height, weight: selectedWeight,gender: widget.gender,),
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

  Widget buildWholeNumberPicker() {
    return Expanded(
      child: CupertinoPicker(
        itemExtent: 40.0,
        onSelectedItemChanged: (index) {
          setState(() {
            selectedWholeNumber = index + 1;
          });
        },
        children: List.generate(300, (index) {
          return Center(
            child: Text(
              '${index + 1}',
              style: TextStyle(fontSize: 20),
            ),
          );
        }),
      ),
    );
  }

  Widget buildDecimalPicker() {
    return Expanded(
      child: CupertinoPicker(
        itemExtent: 40.0,
        onSelectedItemChanged: (index) {
          setState(() {
            selectedDecimal = index;
          });
        },
        children: List.generate(10, (index) {
          return Center(
            child: Text(
              '.$index',
              style: TextStyle(fontSize: 20),
            ),
          );
        }),
      ),
    );
  }
}

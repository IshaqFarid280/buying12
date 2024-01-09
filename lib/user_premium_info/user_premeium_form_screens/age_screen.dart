import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'goals_selectio_screen.dart';


class AgeSelectionScreen extends StatefulWidget {
  final int userId ;
  final double height ;
  final String gender ;
  final double weight ;
  AgeSelectionScreen({required this.userId,required this.height,required this.gender,required this.weight});
  @override
  _AgeSelectionScreenState createState() => _AgeSelectionScreenState();
}

class _AgeSelectionScreenState extends State<AgeSelectionScreen> {
  int selectedAge = 18; // Default age

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Age'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Select your age:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            buildAgePicker(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _navigateToNextScreen(context);
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAgePicker() {
    return CupertinoPicker(
      itemExtent: 40.0,
      onSelectedItemChanged: (index) {
        setState(() {
          selectedAge = index + 18; // Starting age from 18
        });
      },
      children: List.generate(83, (index) {
        return Center(
          child: Text(
            '${index + 18}',
            style: TextStyle(fontSize: 20),
          ),
        );
      }),
    );
  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GoalSelectionScreen(userId: widget.userId,height: widget.height,weight: widget.weight,gender: widget.gender,age: selectedAge,),
      ),
    );
  }
}
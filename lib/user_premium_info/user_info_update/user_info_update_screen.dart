import 'package:buying/consts/colors.dart';
import 'package:buying/widget/buttons.dart';
import 'package:buying/widget/textwidgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'user_info_update_provider.dart';
import 'package:flutter/cupertino.dart';

class UserInfoUpdateScreen extends StatefulWidget {
  final int? userId ;
  final double? height;
  final double? weight;
  final String? gender;
  final int? age;
  final List<String>? goals;
  final String? experience;
  final String? equipment;
  final List<String>? interests;
  final List<String>? focus;
  UserInfoUpdateScreen({
    required this.userId,
    required this.gender,
    required this.height,
    required this.weight,
    required this.age,
    required this.goals,
    required this.experience,
    required this.equipment,
    required this.interests,
    required this.focus,
  });

  @override
  _UserInfoUpdateScreenState createState() => _UserInfoUpdateScreenState();
}

class _UserInfoUpdateScreenState extends State<UserInfoUpdateScreen> {
  String genderController = 'Male';
  double heightController = 0.0;
  int weightIntController = 0;
  double weightDecimalController = 0.0;
  int ageController = 18;
  List<String> goalController = [
    'Keep Healthy',
    'Running',
    'Body Weight',
    'Legs Power',
  ];
  String experienceController = 'New to Exercise';
  String equipmentController = 'Gym';
  List<String> interestController = [
    'Muscles',
    'Packs',
    'Endurance',
    // Add more interests as needed
  ];
  List<String> focusController = [
    'Chest',
    'Legs',
    'Arms',
    'Back',
    // Add more focus options as needed
  ];

  Set<String> selectedGoals = Set();
  Set<String> selectedInterests = Set();
  Set<String> selectedFocus = Set();

  int selectedItem = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        backgroundColor: blackColor,
        leading: LeadingIcon(),
        title: largeText(title: 'Profile Screen')
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(height: 20),
            normalText(title: 'Select Gender'),
            // Gender Selection
            CupertinoSegmentedControl(
              children: {
                'Male': Text('Male'),
                'Female': Text('Female'),
              },
              onValueChanged: (value) {
                setState(() {
                  print(value.toString());
                  genderController = value.toString();
                });
              },
              groupValue: genderController,

              selectedColor: goldenColor, // Change color for selected segment
              unselectedColor: Colors.white, // Change color for unselected segment
              pressedColor: Colors.white, // Change color when pressed
              borderColor: Colors.white, // Change border color
              padding: EdgeInsets.all(10.0), // Adjust padding as needed

            ),

            SizedBox(height: 20),
            // Height Selection
            normalText(title: 'Select Height'),
            Container(
              width: MediaQuery.of(context).size.width*.45,
              height: MediaQuery.of(context).size.height*.1,
              child: CupertinoPicker(

                itemExtent: 50.0,
                onSelectedItemChanged: (index) {
                  setState(() {
                    print(index.toString());
                    heightController = index.toDouble();
                  });
                },
                children: List.generate(200, (index) => AnimatedContainer(
                    width: MediaQuery.of(context).size.width*.5,

                  duration: Duration(microseconds: 300),
                    decoration: BoxDecoration(
                      color: greyColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(child: normalText(title: '${index + 1}', textSize: 14.0)))),
              ),
            ),
            SizedBox(height: 20),
            // Weight Selection
            normalText(title: 'Select Weight'),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width*0.45,
                  height: MediaQuery.of(context).size.height*0.1,
                  child: CupertinoPicker(
                    itemExtent: 32.0,
                    onSelectedItemChanged: (index) {
                      setState(() {
                        print(index.toString());
                        weightIntController = index;
                      });
                    },
                    children: List.generate(200, (index) => AnimatedContainer(
                        width: MediaQuery.of(context).size.width*.5,

                        duration: Duration(microseconds: 300),
                        decoration: BoxDecoration(
                          color: greyColor,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Center(child: normalText(title: '$index', textSize: 14.0)))),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.45,
                  height: MediaQuery.of(context).size.height*0.1,// Set the width you desire
                  child: CupertinoPicker(
                    itemExtent: 32.0,
                    onSelectedItemChanged: (index) {
                      setState(() {
                        print(index.toString());
                        weightDecimalController = index.toDouble() / 10;
                      });
                    },
                    children: List.generate(9, (index) => AnimatedContainer(
                        width: MediaQuery.of(context).size.width*.5,

                        duration: Duration(microseconds: 300),
                        decoration: BoxDecoration(
                          color: greyColor,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Center(child: normalText(title: '.${index + 1}', textSize: 14.0)))),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Age Selection
            normalText(title: 'Select Age'),

            Container(
              width: MediaQuery.of(context).size.width * 0.45,
              height: MediaQuery.of(context).size.height * 0.1,
              child: CupertinoPicker(
                itemExtent: 32.0,
                onSelectedItemChanged: (index) {
                  setState(() {
                    print(index.toString());
                    ageController = index + 1;
                  });
                },
                children: List.generate(
                  9,
                      (index) => AnimatedContainer(
                    width: MediaQuery.of(context).size.width * 0.5,
                    duration: Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      color: index == (weightDecimalController * 10).toInt() ? Colors.transparent : greyColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(child: normalText(title: '${index + 1}', textSize: 14.0)),
                  ),
                ),
              ),
            )
,
            SizedBox(height: 20),
            // Goal Selection
            normalText(title: 'Select Goal(s)'),
            Wrap(
              children: goalController.map(
                    (goal) => ChoiceChip(
                  label: Text(goal),
                  selected: selectedGoals.contains(goal),
                  onSelected: (selected) {
                    setState(() {
                      print(selected.toString());
                      if (selected) {
                        selectedGoals.add(goal);
                      } else {
                        selectedGoals.remove(goal);
                      }
                    });
                  },
                  selectedColor: goldenColor, // Change the color when selected
                      avatar: selectedGoals.contains(goal)
                          ? Icon(Icons.check, color: Colors.white)  // Set the color of the checkmark
                          : null,     labelStyle: TextStyle(
                    color: selectedGoals.contains(goal) ? Colors.white : Colors.black,
                  ),
                ),
              ).toList(),
            ),
            SizedBox(height: 20),
            // Experience Selection
            normalText(title: 'Select Experience Level'),
            CupertinoSegmentedControl(
              children: {
                'New to Exercise': Text('New'),
                'Beginner': Text('Beginner'),
                'Intermediate': Text('Intermediate'),
                'Expert': Text('Expert'),
              },
              onValueChanged: (value) {
                setState(() {
                  print(value.toString());
                  experienceController = value.toString();
                });
              },
              groupValue: experienceController,
            ),
            SizedBox(height: 20),
            // Equipment Selection
            normalText(title: 'Select Equipment'),
            CupertinoSegmentedControl(
              children: {
                'Gym': Text('Gym'),
                'Dumbbells': Text('Dumbbells'),
                'Other': Text('Other'),
              },
              onValueChanged: (value) {
                setState(() {
                  print(value.toString());
                  equipmentController = value.toString();
                });
              },
              groupValue: equipmentController,
            ),
            SizedBox(height: 20),
            // Interest Selection
            normalText(title: 'Select Interest(s)'),
            Text('Select Interest(s)'),
            Wrap(
              children: interestController.map(
                    (interest) => ChoiceChip(
                  label: Text(interest),
                  selected: selectedInterests.contains(interest),
                  onSelected: (selected) {
                    setState(() {
                      print(selected.toString());
                      if (selected) {
                        selectedInterests.add(interest);
                      } else {
                        selectedInterests.remove(interest);
                      }
                    });
                  },
                  selectedColor: Colors.blue, // Change the color when selected
                  labelStyle: TextStyle(
                    color: selectedInterests.contains(interest) ? Colors.white : Colors.black,
                  ),
                ),
              ).toList(),
            ),
            SizedBox(height: 20),
            // Focus Selection
            normalText(title: 'Select Focus Area(s)'),
            Wrap(
              children: focusController.map(
                    (focus) => ChoiceChip(
                  label: Text(focus),
                  selected: selectedFocus.contains(focus),
                  onSelected: (selected) {
                    setState(() {
                      print(selected.toString());
                      if (selected) {
                        selectedFocus.add(focus);
                      } else {
                        selectedFocus.remove(focus);
                      }
                    });
                  },
                  selectedColor: Colors.orange, // Change the color when selected
                  labelStyle: TextStyle(
                    color: selectedFocus.contains(focus) ? Colors.white : Colors.black,
                  ),
                ),
              ).toList(),
            ),
            SizedBox(height: 20),
            // Submit Button
            ElevatedButton(
              onPressed: () {
                final userInformationProvider =
                Provider.of<UserInformationUpdateProvider>(context, listen: false);
                // Clean up the weight string and format it as a valid double
                final String weightString = '$weightIntController.$weightDecimalController';
                final double weight = double.tryParse(weightString) ?? 0.0;
                final userInformation = UserInformationUpdate(
                  gender: genderController,
                  height: heightController.toString(),
                  weight: weight.toString(),
                  age: ageController.toString(),
                  goal: goalController.toString().split(','),
                  experience: experienceController,
                  equipment: equipmentController,
                  interest: interestController.toString().split(','),
                  focus: focusController.toString().split(','),
                );

                userInformationProvider.updateUserInformation(userInformation, widget.userId.toString());
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
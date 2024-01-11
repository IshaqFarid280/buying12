import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  // Define variables for user details
  String gender = '';
  String height = '';
  String weight = '';
  int age = 0;
  String experience = '';
  String equipment = '';
  List<String> goals = [];
  List<String> interests = [];
  List<String> focus = [];

  // Function to update user details
  void updateUserDetails(Map<String, dynamic> userDetails) {
    gender = userDetails['gender'];
    height = userDetails['height'];
    weight = userDetails['weight'];
    age = userDetails['age'];
    experience = userDetails['experience'];
    equipment = userDetails['equipment'];
    goals = List<String>.from(userDetails['goals']);
    interests = List<String>.from(userDetails['interests']);
    focus = List<String>.from(userDetails['focus']);

    notifyListeners();
  }



}

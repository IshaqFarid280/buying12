import 'dart:convert';

import 'package:buying/premium_api_links/api_controller.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class UserInformationUpdate {
  final String gender;
  final String height;
  final String weight;
  final String age;
  final List<String> goal;
  final String experience;
  final String equipment;
  final List<String> interest;
  final List<String> focus;

  UserInformationUpdate({
    required this.gender,
    required this.height,
    required this.weight,
    required this.age,
    required this.goal,
    required this.experience,
    required this.equipment,
    required this.interest,
    required this.focus,
  });

  // Convert the object to a Map for JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'gender': gender,
      'height': height,
      'weight': weight,
      'age': age,
      'goal': goal.join(','),
      'experience': experience,
      'equipment': equipment,
      'interest': interest,
      'focus': focus,
    };
  }
}


class UserInformationUpdateProvider extends ChangeNotifier {
  Future<void> updateUserInformation(UserInformationUpdate userInformation,userId) async {
    final Uri uri = Uri.parse('${ApiServices.updateUsersInfo}/$userId');

    try {
      final response = await http.post(
        uri,
        body: {
          'gender': userInformation.gender,
          'height': userInformation.height.toString(),
          'weight': userInformation.weight.toString(),
          'age': userInformation.age.toString(),
          'goal': userInformation.goal.join(','),
          'experience': userInformation.experience,
          'equipment': userInformation.equipment,
          'interest': userInformation.interest.join(','),
          'focus[]': jsonEncode(userInformation.focus), // Pass focus as a list
        },
      );
      print('API response:update');
      print('Error: ${response.statusCode}');
      if (response.statusCode == 200) {
        // Handle the successful response
        final Map<String, dynamic> responseData = json.decode(response.body);
        final Map<String, dynamic> data = responseData['data'];
        final List<String> focus = List<String>.from(data['focus']);
        print('API response:update');
        print('Error: ${response.statusCode}');
        print('Error body: ${response.body}');
      } else {
        // Handle error response
        print('Error: ${response.statusCode}');
        print('Error body: ${response.body}');
      }
    } catch (e) {
      print('Exception during API call: $e');
    }
  }
}

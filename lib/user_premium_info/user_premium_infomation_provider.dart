import 'package:buying/premium_api_links/api_controller.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class UserInformation {
  final String userId;
  final String gender;
  final String height;
  final String weight;
  final String age;
  final List<String> goal;
  final String experience;
  final String equipment;
  final List<String> interest;
  final List<String> focus;

  UserInformation({
    required this.userId,
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
      'user_id': userId,
      'gender': gender,
      'height': height.toString(),
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

class UserInformationProvider extends ChangeNotifier {

  Future<void> postUserInformation(UserInformation userInformation) async {
    final Uri uri = Uri.parse(ApiServices.postUserInfo);
    try {
      final response = await http.post(
        uri,
        body: {
          'user_id': userInformation.userId,
          'gender': userInformation.gender,
          'height': userInformation.height.toString(),
          'weight': userInformation.weight.toString(),
          'age': userInformation.age.toString(),
          'goal': userInformation.goal.join(','),
          'experience': userInformation.experience,
          'equipment': userInformation.equipment,
          'interest': userInformation.interest.join(','),
          'focus[]': jsonEncode(userInformation.focus),
        },
      );
      if (response.statusCode == 200) {
        // Handle the successful response
        final Map<String, dynamic> responseData = json.decode(response.body);
        final Map<String, dynamic> data = responseData['data'];
        final List<String> focus = List<String>.from(data['focus']);
      } else {
        // Handle error response
        print('Error: ${response.statusCode}');
        print('Error: ${response.body.toString()}');
      }
    } catch (e) {
      print('Exception during API call: $e');
    }
  }

  Future<void> deleteUserInformation(int userId) async {
    final response = await http.get(Uri.parse('${ApiServices.deleteUsersInfo}/$userId'));

    if (response.statusCode == 200) {
      // Successful deletion
      print('User information deleted successfully.');
      // Notify listeners that the data has changed
      notifyListeners();
    } else {
      // Failed to delete user information
      print('Failed to delete user information. Status code: ${response.statusCode}');
      throw Exception('Failed to delete user information');
    }
  }
}
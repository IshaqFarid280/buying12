// Model to represent the user program
import 'dart:convert';

import 'package:buying/premium_api_links/api_controller.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserProgram {
  final int id;
  final String name;
  UserProgram({required this.id, required this.name});

  factory UserProgram.fromJson(Map<String, dynamic> json) {
    return UserProgram(
      id: json['id'],
      name: json['program_name'],
    );
  }
}

// Provider class to handle the API call and manage the state
// class UserProgramProvider extends ChangeNotifier {
//   List<UserProgram> _programs = [];
//   List<UserProgram> get programs => _programs;
//
//   String _message = "";
//   String get message => _message;
//
//   Future<void> fetchPrograms({required userId}) async {
//     final response = await http.get(Uri.parse('${ApiServices.getAssignWorkoutProgram}?user_id=$userId&request_type=user'));
//     print(response.statusCode);
//     // print(response.body.toString());
//     if (response.statusCode == 200) {
//       final List<dynamic> data = json.decode(response.body)['data'];
//       _message = data['message']['success'];
//
//       _programs = data.map((program) => UserProgram.fromJson(program)).toList();
//       notifyListeners();
//     } else {
//       throw Exception('Failed to load programs');
//     }
//   }
// }
class UserProgramProvider extends ChangeNotifier {
  List<UserProgram> _programs = [];
  List<UserProgram> get programs => _programs;

  String _message = "";
  String get message => _message;

  Future<void> fetchPrograms({required userId}) async {
    final response = await http.get(Uri.parse('${ApiServices.getAssignWorkoutProgram}?user_id=$userId&request_type=user'));
    print(response.statusCode);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      // Assuming 'message' is at the top level
      _message = responseData['message']['success'];

      final List<dynamic> data = responseData['data'];
      _programs = data.map((program) => UserProgram.fromJson(program)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load programs');
    }
  }
}

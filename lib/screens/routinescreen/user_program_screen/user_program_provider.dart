// Model to represent the user program
import 'dart:convert';

import 'package:buying/premium_api_links/api_controller.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserProgram {
  final int id;
  final String name;

  UserProgram({required this.id, required this.name});
}

// Provider class to handle the API call and manage the state
class UserProgramProvider extends ChangeNotifier {
  List<UserProgram> _userPrograms = [];
  bool _isFetched = false;  // Add this line
  String? _error;  // Add this line

  List<UserProgram> get userPrograms => _userPrograms;
  bool get isFetched => _isFetched;  // Add this getter
  String? get error => _error;  // Add this getter

  Future<void> fetchUserPrograms(int userId) async {
    _isFetched = false;  // Reset the flag before fetching

    final url = Uri.parse('${ApiServices.basicUrl}/program?user_id=$userId&user_program=true');


    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body)['data'];
        _userPrograms = responseData.map((data) => UserProgram(id: data['id'], name: data['name'])).toList();
        _isFetched = true;
      } else {
        _error = 'Failed to load user programs';
      }
    } catch (error) {
      _error = 'Error: $error';
    }

    notifyListeners();
  }

  // Function to trigger fetching without exposing fetchUserPrograms directly
  Future<void> triggerFetch(int userId) async {
    await fetchUserPrograms(userId);
  }
}

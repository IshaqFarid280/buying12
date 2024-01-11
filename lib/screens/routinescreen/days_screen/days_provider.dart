// Model to represent the day
import 'dart:convert';
import 'package:buying/premium_api_links/api_controller.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class Day {
  final int daysid;
  final String days;
  final int programId;
  final String? userid;
  final DateTime createdAt;
  final DateTime updatedAt;

  Day({
    required this.daysid,
    required this.days,
    required this.programId,
    required this.userid,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Day.fromJson(Map<String, dynamic> json) {
    return Day(
      daysid: json['id'],
      days: json['day_name'],
      programId: json['program_id'],
      userid: json['user_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class DayProvider with ChangeNotifier {
  List<Day> _days = [];
  List<Day> get days => _days;

  Future<void> fetchDays({required programId, required userId}) async {
    try {
      final response = await http.get(Uri.parse('${ApiServices.getDay}/$programId?user_id=$userId&request_type=user'));
      if (response.statusCode == 200) {
        // print(response.body);
        final dynamic responseData = json.decode(response.body)['data'];
        if (responseData != null && responseData is List) {
          _days = responseData.map((json) => Day.fromJson(json)).toList();
          notifyListeners();
        } else {
          throw Exception('Invalid data format');
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error, stacktrce) {
      print('Day method Error: $error');
      print('Day method stacktrace: $stacktrce');
    }
  }

  Future<void> postDay( dayName,  programId,context, userId) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiServices.postDay_user_api}?user_id=$userId&request_type=user'),
        body: {
          'day_name': dayName,
          'program_id':programId
        },
      );
      // print(response.body.toString());
      // print(response.statusCode);
      if (response.statusCode == 200) {
        Navigator.pop(context);  // Refresh the list after a successful post
      } else {
        throw Exception('Failed to post data');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> updateDay(String dayId, String newDayName,context) async {
    try {
      final response = await http.post(
          Uri.parse('${ApiServices.updateDay}/$dayId'),
          body: {
            'name': newDayName,
          }
      );
      if (response.statusCode == 200) {
        Navigator.pop(context);
        // Refresh the list after a successful update
      } else {
        throw Exception('Failed to update data');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> deleteDays(int dayId) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiServices.destroyDay}/$dayId/destroy'),
      );
      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, the program was successfully deleted
        print('Program deleted successfully');
      } else {
        // throw an exception or handle the error accordingly.
        throw Exception('Failed to delete program');
      }
    } catch (error) {
      // Handle network or other errors
      print('Error: $error');
      throw Exception('Failed to delete program');
    }
  }
}
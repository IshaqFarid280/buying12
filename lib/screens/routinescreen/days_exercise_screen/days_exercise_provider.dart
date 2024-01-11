import 'dart:convert';

import 'package:buying/premium_api_links/api_controller.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class DayExercise {
  final int id;
  final int dayId;
  final String exerciseName;
  final String exerciseDescription;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String exerciseImage; // Add this line

  DayExercise({
    required this.id,
    required this.dayId,
    required this.exerciseName,
    required this.exerciseDescription,
    required this.createdAt,
    required this.updatedAt,
    required this.exerciseImage, // Add this line
  });

  factory DayExercise.fromJson(Map<String, dynamic> json) {
    return DayExercise(
      id: json['id'],
      dayId: json['day_id'],
      exerciseName: json['exercise_name'],
      exerciseDescription: json['exercise_description'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      exerciseImage: json['exercise_image'], // Add this line
    );
  }
}


class DayExerciseProvider with ChangeNotifier {
  List<DayExercise> _dayExercises = [];
  List<DayExercise> get dayExercises => _dayExercises;

  Future<void> fetchDayExercises({required userId, required dayId}) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiServices.getAssignDaysExercise}/$dayId?user_id=$userId&request_type=user'),
      );

      if (response.statusCode == 200) {
        // print(response.body);
        final dynamic responseData = json.decode(response.body)['data'];
        // print(responseData);
        if (responseData != null && responseData is List) {
          _dayExercises = responseData.map((json) => DayExercise.fromJson(json)).toList();
          // final dayExercise = DayExercise.fromJson(responseData);
          // _dayExercises = [dayExercise];
          notifyListeners();
        } else {
          throw Exception('Invalid data format');
        }
      } else {
        throw Exception('Failed to load data in days exercise screen');
      }
    } catch (error, stacktrace) {
      print('Error: $error');
      print('Stacktrace: $stacktrace');
    }
  }
}
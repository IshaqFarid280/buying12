import 'dart:convert';
import 'package:buying/premium_api_links/api_controller.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class ExerciseSet {
  final int id;
  final String kg;
  final String reps;
  final int dayExerciseId;
  final String createdAt;
  final String updatedAt;

  ExerciseSet({
    required this.id,
    required this.kg,
    required this.reps,
    required this.dayExerciseId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ExerciseSet.fromJson(Map<String, dynamic> json) {
    return ExerciseSet(
      id: json['id'],
      kg: json['kg'],
      reps: json['reps'],
      dayExerciseId: json['day_exercise_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class SetProvider with ChangeNotifier {

  List<ExerciseSet> _exerciseSets = [];
  bool _isLoading = false;

  List<ExerciseSet> get exerciseSets => _exerciseSets;
  bool get isLoading => _isLoading;

  Future<void> fetchExerciseSets({
    required exerciseId,
    required userId
  }) async {

    try {
      final response = await http.get(Uri.parse('${ApiServices.getSets}/$exerciseId?user_id=$userId&request_type=user'));

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body)['data'];
        _exerciseSets = responseData.map((json) => ExerciseSet.fromJson(json)).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching exercise sets: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> postExerciseSet({
    required List<String> kg,
    required List<String> reps,
    required String dayExerciseId,
    required String userID,
    required BuildContext context,
  }) async {
    try {
      final apiUrl = '${ApiServices.basicUrl}/set?user_id=$userID&request_type=user';

      // Convert string values to double and int
      double kgValue = double.parse(kg.first);
      int repsValue = int.parse(reps.first);

      // Prepare the form data
      var body = {
        'kg[0]': kgValue.toString(),
        'reps[0]': repsValue.toString(),
        'day_exercise_id': dayExerciseId,
      };

      // Make the POST request
      var response = await http.post(Uri.parse(apiUrl), body: body);
      if(response.statusCode == 200){
        Navigator.pop(context);
        // Optionally, you can handle the response here
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
      }else{
        print('Response body: ${response.body}');
      }
      // Notify listeners after the request is completed
      notifyListeners();
    } catch (e) {
      // Handle the error
      print('Error: $e');
    }
  }

  Future<void> updateExerciseSet({
    required String setId,
    required String userId,
    required List<String> kg,
    required List<String> reps,
    required BuildContext context,
  }) async {
    try {
      // Convert string values to double and int
      double kgValue = double.parse(kg.first);
      int repsValue = int.parse(reps.first);

      // Prepare the form data
      var body = {
        'kg[0]': kgValue.toString(),
        'reps[0]': repsValue.toString(),
      };

      // Make the POST request
      var response = await http.post(Uri.parse('${ApiServices.updateSets}/$setId?user_id=$userId&request_type=user'), body: body);

      if (response.statusCode == 200) {
        Navigator.pop(context);
        // Optionally, you can handle the response here
        print('Update Response status: ${response.statusCode}');
        print('Update Response body: ${response.body}');
      } else {
        print('Update Response body: ${response.body}');
      }

      // Notify listeners after the request is completed
      notifyListeners();
    } catch (e) {
      // Handle the error
      print('Update Error: $e');
    }
  }

  Future<void> deleteExerciseSet({
    required String setId,
  }) async {
    try {
      var response = await http.get(Uri.parse('${ApiServices.destroySets}/$setId/destroy'));
      if (response.statusCode == 200) {
        // Optionally, you can handle the response here
        print('Delete successful. Response status: ${response.statusCode}');
      } else {
        // Optionally, handle the error response
        print('Failed to delete set. Response status: ${response.statusCode}');
      }

      // Notify listeners after the request is completed
      notifyListeners();
    } catch (e) {
      // Handle the error
      print('Error: $e');
    }
  }



}

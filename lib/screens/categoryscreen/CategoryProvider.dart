import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:buying/premium_api_links/api_controller.dart';

class Exercise {
  final int id;
  final String name;
  final String description;
  final String gifUrl;
  final int categoryId;

  Exercise({
    required this.id,
    required this.name,
    required this.description,
    required this.gifUrl,
    required this.categoryId,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'],
      name: json['exercise_name'],
      description: json['exercise_description'],
      gifUrl: json['exercise_gif'],
      categoryId: json['category_id'],
    );
  }
}

class Category {
  final int id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;

  Category({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });
}

class CategoryProvider with ChangeNotifier {
  List<Category> _categories = [];
  int _categoriesLength = 0;
  List<Exercise> _exercises = [];

  List<Category> get categories => _categories;
  int get categoriesLength => _categoriesLength;
  List<Exercise> get exercises => _exercises;

  Future<List<Category>> fetchCategories() async {
    try {
      final response = await http.get(Uri.parse('${ApiServices.basicUrl}/category'));
      // print(response.body);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        _categories = (jsonData['data'] as List)
            .map((categoryJson) => Category(
          id: categoryJson['id'],
          name: categoryJson['name'],
          createdAt: DateTime.parse(categoryJson['created_at']),
          updatedAt: DateTime.parse(categoryJson['updated_at']),
        ))
            .toList();
        notifyListeners();
        return categories;
      } else {
        print('HTTP error status code: ${response.statusCode}');
        throw Exception('Failed to load categories');
      }
    } catch (error) {
      print('Error fetching categories: $error');
      throw Exception('Failed to load categories');
    }
  }

  Future<void> addCategory(String categoryName) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiServices.basicUrl}/category/store'),
        body: {'name': categoryName},
      );

      final responseData = json.decode(response.body);

      if (response.statusCode == 200 && responseData['message'] != null) {
        print('Category created successfully');
        await fetchCategories();
      } else {
        print('Failed to create category: ${responseData['message']}');
        throw Exception('Failed to create category');
      }
    } catch (error) {
      print('Error creating category: $error');
      throw Exception('Failed to create category');
    }
  }

  Future<List<Exercise>> fetchCategoryExercises(int categoryId) async {
    // print('Category id on which new exercise is created: $categoryId');
    try {
      final response = await http.get(Uri.parse('${ApiServices.getAllCategories}/$categoryId'));
      if (response.statusCode == 200) {
        // print('Status Code: ${response.statusCode}');
        // print('Number of exercises: ${_exercises.length}');

        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> exercisesData = responseData['data']['exercises'];
        // print('Response data Code: ${response.body}');

        _exercises = exercisesData
            .map((exerciseData) => Exercise(
          id: exerciseData['id'],
          name: exerciseData['exercise_name'],
          description: exerciseData['exercise_description'],
          gifUrl: exerciseData['exercise_gif'],
          categoryId: exerciseData['category_id'],
        ))
            .toList();

        return _exercises;
      } else {
        print('HTTP error status code: ${response.statusCode}');
        throw Exception('Failed to load exercises for the category');
      }
    } catch (error) {
      print('Error fetching exercises: $error');
      throw Exception('Failed to load exercises');
    }
  }
}

class ApiProvider {
  Future<List<Category>> fetchCategories() async {
    try {
      final response = await http.get(Uri.parse('${ApiServices.basicUrl}/category'));
      if (response.statusCode == 200) {
        // print('fetching category: ${response.statusCode}');
        // print('fetching category: ${response.body}');
        final jsonData = json.decode(response.body);
        return (jsonData['data'] as List)
            .map((categoryJson) => Category(
          id: categoryJson['id'],
          name: categoryJson['name'],
          createdAt: DateTime.parse(categoryJson['created_at']),
          updatedAt: DateTime.parse(categoryJson['updated_at']),
        ))
            .toList();
      } else {
        print('HTTP error status code: ${response.statusCode}');
        throw Exception('Failed to load categories');
      }
    } catch (error) {
      print('Error fetching categories: $error');
      throw Exception('Failed to load categories');
    }
  }

  Future<void> addCategory(String categoryName) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiServices.basicUrl}/category/store'),
        body: {'name': categoryName},
      );

      final responseData = json.decode(response.body);

      if (response.statusCode == 200 && responseData['message'] != null) {
        print('Category created successfully');
      } else {
        print('Failed to create category: ${responseData['message']}');
        throw Exception('Failed to create category');
      }
    } catch (error) {
      print('Error creating category: $error');
      throw Exception('Failed to create category');
    }
  }

  Future<List<Exercise>> fetchCategoryExercises(int categoryId) async {
    print('Category id on which new exercise is created: $categoryId');
    try {
      final response = await http.get(Uri.parse('${ApiServices.getAllCategories}/$categoryId'));
      print(response.body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> exercisesData = responseData['data']['exercises'];

        return exercisesData
            .map((exerciseData) => Exercise(
          id: exerciseData['id'],
          name: exerciseData['exercise_name'],
          description: exerciseData['exercise_description'],
          gifUrl: exerciseData['exercise_gif'],
          categoryId: exerciseData['category_id'],
        ))
            .toList();
      } else {
        print('HTTP error status code: ${response.statusCode}');
        throw Exception('Failed to load exercises for the category');
      }
    } catch (error) {
      print('Error fetching exercises: $error');
      throw Exception('Failed to load exercises');
    }
  }
}
import 'dart:convert';
import 'package:buying/premium_api_links/api_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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


  List<Category> get categories => _categories;
  int get categoriesLength => _categoriesLength;

  Future<void> fetchCategories() async {
    try {
      final response = await http.get(Uri.parse(('${ApiServices.basicUrl}/category')));
      // print('Response Body: ${response.body}');
      if (response.statusCode == 200) {
        // Parse the response JSON and update the list of categories
        final jsonData = json.decode(response.body);
        _categories = (jsonData['data'] as List)
            .map((categoryJson) => Category(
          id: categoryJson['id'],
          name: categoryJson['name'],
          createdAt: DateTime.parse(categoryJson['created_at']),
          updatedAt: DateTime.parse(categoryJson['updated_at']),
        ))
            .toList();
        _categoriesLength = _categories.length;

        notifyListeners();
      } else {
        // Log the HTTP error status code
        print('HTTP error status code: ${response.statusCode}');
        throw Exception('Failed to load categories');
      }
    } catch (error) {
      // Log the error message
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
        // You can handle the successful creation as needed.
        // For example, you might want to update the local list of categories.
        // Fetching categories again to get the updated list.
        await fetchCategories();
      } else {
        // Log the error message
        print('Failed to create category: ${responseData['message']}');
        throw Exception('Failed to create category');
      }
    } catch (error) {
      // Log the error message
      print('Error creating category: $error');
      throw Exception('Failed to create category');
    }
  }

  Future<List<Exercise>> fetchCategoryExercises(int categoryId) async {
    final response = await http.get( Uri.parse('${ApiServices.basicUrl}/category/$categoryId'));
    // print('Response Body exercises: ${response.body}');
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> exercisesData = responseData['data']['exercises'];
      return exercisesData.map((exercise) => Exercise.fromJson(exercise)).toList();
    } else {
      // Log the HTTP error status code
      print('HTTP error status code: ${response.statusCode}');
      throw Exception('Failed to load exercises for the category');
    }
  }



}

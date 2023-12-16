import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

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

  List<Category> get categories => _categories;

  Future<void> fetchCategories() async {
    try {
      final response = await http.get(Uri.parse(('http://192.168.1.5:8000/api/category')));

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
}

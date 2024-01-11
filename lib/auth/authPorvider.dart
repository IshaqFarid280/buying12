import 'dart:convert';
import 'package:buying/premium_api_links/api_controller.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserResponse {
  late final String message;
  late final UserData data;

  UserResponse({required this.message, required this.data});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      message: json['message']['success'],
      data: UserData.fromJson(json['data']),
    );
  }
}

class UserData {
  late final String name;
  late final String email;
  late final String updatedAt;
  late final String createdAt;
  late final int id;

  UserData({
    required this.name,
    required this.email,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      name: json['name'],
      email: json['email'],
      updatedAt: json['updated_at'],
      createdAt: json['created_at'],
      id: json['id'],
    );
  }
}



class UserProvider extends ChangeNotifier {
  final String baseUrl = ApiServices.basicUrl;

  Future<UserResponse> signUp(String name, String email, String password, String confirmPassword) async {
    final url = Uri.parse('$baseUrl/signUp');
    final response = await http.post(
      url,
      body:{
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': confirmPassword,
      },
    );
    print(response.statusCode);
    print(response.body.toString());
    if (response.statusCode == 200) {
      print('in 200 signup status code : ${response.statusCode}');
      final Map<String, dynamic> responseData = json.decode(response.body);
      return UserResponse.fromJson(responseData);
    } else {
      print('in else statment : ${response.statusCode}');
      throw Exception('Failed to sign up');
    }
  }


  Future<UserResponse> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/login');

    try {
      final response = await http.post(
        url,
        body: {
          'email': email,
          'password': password,
        },

      );
      print(response.statusCode);
      print(response.body.toString());

      if (response.statusCode == 200) {
        print('in 200 login status code : ${response.statusCode}');
        final Map<String, dynamic> responseData = json.decode(response.body);
        return UserResponse.fromJson(responseData);
      } else {
        throw Exception('Failed to login');
      }
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

}

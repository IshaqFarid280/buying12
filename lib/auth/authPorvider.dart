import 'dart:convert';
import 'package:buying/consts/String.dart';
import 'package:buying/premium_api_links/api_controller.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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

class SubscriptionModel {
  late final String message;
  late final SubscriptionData data;

  SubscriptionModel({required this.message, required this.data});

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(
      message: json['message']['success'],
      data: SubscriptionData.fromJson(json['data']),
    );
  }
}

class SubscriptionData {
  late final int id;
  late final int userId;
  late final String subscriptionPlan;
  late final String purchaseDate;
  late final String status;
  late final int isFirst;
  late final DateTime createdAt;
  late final DateTime updatedAt;
  late final DateTime expiryDate;

  SubscriptionData({
    required this.id,
    required this.userId,
    required this.subscriptionPlan,
    required this.purchaseDate,
    required this.status,
    required this.isFirst,
    required this.createdAt,
    required this.updatedAt,
    required this.expiryDate,
  });

  factory SubscriptionData.fromJson(Map<String, dynamic> json) {
    return SubscriptionData(
      id: json['id'],
      userId: json['user_id'],
      subscriptionPlan: json['subscription_plan'],
      purchaseDate: json['purchase_date'],
      status: json['status'],
      isFirst: json['is_first'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      expiryDate: DateTime.parse(json['expiry_date']),
    );
  }
}




class UserProvider extends ChangeNotifier {
  final String baseUrl = ApiServices.basicUrl;

  // Save user ID to SharedPreferences
  Future<void> saveUserId(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_id', userId);
  }

  // Retrieve user ID from SharedPreferences
  Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_id');
  }

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
    if (response.statusCode == 200) {
      print('in 200 signup status code : ${response.statusCode}');
      final Map<String, dynamic> responseData = json.decode(response.body);
      final UserResponse userResponse = UserResponse.fromJson(responseData);
      // Save user ID to SharedPreferences
      saveUserId(userResponse.data.id.toString());
      return userResponse;
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
      if (response.statusCode == 200) {
        print('in 200 login status code : ${response.statusCode}');
        final Map<String, dynamic> responseData = json.decode(response.body);
        final UserResponse userResponse = UserResponse.fromJson(responseData);
        // Save user ID to SharedPreferences
        saveUserId(userResponse.data.id.toString());
        return userResponse;
      } else {
        throw Exception('Failed to login');
      }
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

  // Subscription method
  Future<SubscriptionModel> fetchSubscriptionData(String userId) async {
    print('before function hit suscrition : $userId');
    final url = Uri.parse('$baseUrl/subscription?user_id=$userId');
    final response = await http.get(url);
    print('suscrition : $userId');
    print('suscrition : ${response.statusCode}');
    print('suscrition : ${response.body.toString()}');
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      print(response.body.toString());
      return SubscriptionModel.fromJson(data);
    } else {
      throw Exception('Failed to load subscription data');
    }
  }

}
//
// String userId = responseData['id'];
// print('userid Signup id : $userId');
// usersID = userId ;
// print('userID : $usersID');
// prefs.setString('userId', userId);
// notifyListeners();
//

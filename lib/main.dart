import 'dart:convert';
import 'package:buying/auth/authPorvider.dart';
import 'package:buying/premiium_all_exercises_categories/CategoryProvider.dart';
import 'package:buying/premiium_all_exercises_categories/category_screen.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'premium_buy_screens/buy_screen_provider.dart';

void main() {
  // InAppPurchaseAndroidPlatformAddition.enablePendingPurchases();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => UserProvider()),
      ChangeNotifierProvider(create: (context) => CategoryProvider()),
      ChangeNotifierProvider(create: (context) => SubscriptionProvider()),
    ],
      child: MyApp()));
}
//
// void main() {
//   InAppPurchaseAndroidPlatformAddition.enablePendingPurchases();
//   runApp(MyApp());
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Title',
      home: YourHomePage(),
    );
  }
}


import 'package:buying/auth/authPorvider.dart';
import 'package:buying/auth/login_screen.dart';
import 'package:buying/screens/categoryscreen/CategoryProvider.dart';
import 'package:buying/screens/categoryscreen/exerciseProvider.dart';
import 'package:buying/screens/categoryscreen/category_screen.dart';
import 'package:buying/screens/profilescreen/profileprovider.dart';
import 'package:buying/screens/routinescreen/days_exercise_screen/days_exercise_provider.dart';
import 'package:buying/screens/routinescreen/days_screen/days_provider.dart';
import 'package:buying/screens/routinescreen/setscreen/sets_provider.dart';
import 'package:buying/screens/routinescreen/user_program_screen/user_program_provider.dart';
import 'package:buying/subscription_Screens/buy_screen_provider.dart';
import 'package:buying/user_premium_info/user_info_update/user_info_update_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'user_premium_info/user_premium_infomation_provider.dart';

void main() {

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => UserProvider()),
      ChangeNotifierProvider(create: (context) => CategoryProvider()),
      ChangeNotifierProvider(create: (context) => SubscriptionProvider()),
      ChangeNotifierProvider(create: (context) => ExerciseProvider()),
      ChangeNotifierProvider(create: (context) => UserInformationProvider()),
      ChangeNotifierProvider(create: (context) => CategoryProviderr()),
      ChangeNotifierProvider(create: (context) => UserInformationUpdateProvider()),
      ChangeNotifierProvider(create: (context) => ProfileProvider()),
      ChangeNotifierProvider(create: (context) => UserProgramProvider()),
      ChangeNotifierProvider(create: (context) => DayProvider()),
      ChangeNotifierProvider(create: (context) => DayExerciseProvider()),
      ChangeNotifierProvider(create: (context) => SetProvider()),
    ],
      child: MyApp()));
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Title',
      home: LoginScreen(),
    );
  }
}

import 'package:buying/auth/login_screen.dart';
import 'package:buying/auth/signupscreen.dart';
import 'package:buying/bottomNavigationBar.dart';
import 'package:buying/consts/colors.dart';
import 'package:buying/user_premium_info/user_premeium_form_screens/gender_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth/authPorvider.dart';
import '../consts/String.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: Provider.of<UserProvider>(context, listen: false).getUserId(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          String? userId = snapshot.data;
          if (userId != null) {
            print('User ID: $userId'); // Debug

            // Check if there is saved subscription information
            String? savedMessage;
            int savedIsFirst; // Change the type to int

            getSubscriptionMessage().then((value) {
              savedMessage = value;

              getSubscriptionIsFirst().then((value) {
                savedIsFirst = value ?? 0; // Use the null-aware operator to handle null

                // Now you have both savedMessage and savedIsFirst
                if (savedMessage != null) {
                  // Use saved information for navigation
                  print('Saved subscription info found: $savedMessage, $savedIsFirst'); // Debug
                  navigateBasedOnSubscription(context, savedMessage.toString(), savedIsFirst, userId);
                } else {
                  // No saved info or it's outdated, make API call
                  Provider.of<UserProvider>(context, listen: false)
                      .fetchSubscriptionData(userId)
                      .then((subscriptionModel) async {
                    // Save subscription information to shared preferences
                    await saveSubscriptionInfo(subscriptionModel.message, subscriptionModel.data.isFirst);
                    print('Saved to shared preferences: ${subscriptionModel.message}, ${subscriptionModel.data.isFirst}'); // Debug

                    // Use the latest information for navigation
                    navigateBasedOnSubscription(context, subscriptionModel.message, subscriptionModel.data.isFirst, userId);
                  });
                }
              });
            });

            // Return a placeholder while waiting for the API call to complete
            return Scaffold(
              body: Center(
                child: Image.asset(splash,),
              ),
            );
          } else {
            // Navigate to the login or signup screen
            _navigateToSignUp(context);
            // Return a placeholder or an appropriate widget
            return Scaffold(
              backgroundColor: backGroundColor,
              body: Center(
                child: Container(
                  width:100,
                  height: 100,
                  decoration:  BoxDecoration(
                    image: DecorationImage(image: AssetImage(splash),isAntiAlias: true,fit: BoxFit.cover),
                  ),
                ),
              ),
            ); // You can use a different widget here
          }
        } else {
          // Loading indicator or splash screen
          return Scaffold(
            backgroundColor: backGroundColor,
            body: Center(
              child: Container(
                width:100,
                height: 100,
                decoration:  BoxDecoration(
                  image: DecorationImage(image: AssetImage(splash),isAntiAlias: true,fit: BoxFit.cover),
                ),
              ),
            ),
          );
        }
      },
    );
  }

  void _navigateToBottomNavigation(BuildContext context, userId) {
    Future.delayed(Duration.zero, () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BottomNavigationScreen(userId: int.parse(userId)),
        ),
      );
    });
  }

  void _navigateToGenderSelection(BuildContext context, String userId) {
    Future.delayed(Duration.zero, () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => GenderSelectionScreen(userId: int.parse(userId)),
        ),
      );
    });
  }

  void _navigateToLogin(BuildContext context) {
    Future.delayed(Duration.zero, () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

  void _navigateToSignUp(BuildContext context) {
    Future.delayed(Duration.zero, () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignUpScreen()),
      );
    });
  }

  // Save subscription information to shared preferences
  Future<void> saveSubscriptionInfo(String message, int isFirst) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('subscription_message', message);
    prefs.setInt('subscription_is_first', isFirst);
  }

  // Retrieve subscription message from shared preferences
  Future<String?> getSubscriptionMessage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('subscription_message');
  }

  // Retrieve subscription isFirst from shared preferences
  Future<int?> getSubscriptionIsFirst() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('subscription_is_first');
  }

  // Navigate based on subscription information
  void navigateBasedOnSubscription(BuildContext context, String message, int isFirst, String userId) {
    print('Navigating based on subscription: $message, $isFirst'); // Debug
    if (message == 'Successfully retrieved.' && isFirst == 0) {
      _navigateToBottomNavigation(context, userId);
    } else if (message == 'Successfully retrieved.' && isFirst == 1) {
      _navigateToGenderSelection(context, userId);
    } else {
      _navigateToLogin(context);
    }
  }
}

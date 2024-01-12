import 'package:buying/auth/login_screen.dart';
import 'package:buying/auth/signupscreen.dart';
import 'package:buying/bottomNavigationBar.dart';
import 'package:buying/user_premium_info/user_premeium_form_screens/gender_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth/authPorvider.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: Provider.of<UserProvider>(context, listen: false).getUserId(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          String? userId = snapshot.data;
          if (userId != null) {
            print(userId.toString());
            Provider.of<UserProvider>(context, listen: false)
                .fetchSubscriptionData(userId)
                .then((subscriptionModel) {
              if (subscriptionModel.message == 'Successfully retrieved.' &&
                  subscriptionModel.data.isFirst == 0) {
                _navigateToBottomNavigation(context, subscriptionModel.data.userId);
              } else if (subscriptionModel.message == 'Successfully retrieved.' &&
                  subscriptionModel.data.isFirst == 1) {
                _navigateToGenderSelection(context, subscriptionModel.data.userId.toString());
              } else {
                _navigateToLogin(context);
              }
            });
            // Return a placeholder while waiting for the API call to complete
            return LoginScreen();
          } else {
            // Navigate to the login or signup screen
            _navigateToSignUp(context);
            // Return a placeholder or an appropriate widget
            return Container(); // You can use a different widget here
          }
        } else {
          // Loading indicator or splash screen
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
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
          builder: (context) => BottomNavigationScreen(userId: userId),
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
}

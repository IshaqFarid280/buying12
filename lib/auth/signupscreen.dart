import 'package:buying/auth/login_screen.dart';
import 'package:buying/consts/colors.dart';
import 'package:buying/main.dart';
import 'package:buying/subscription_Screens/premiuim_buy.dart';
import 'package:buying/widget/buttons.dart';
import 'package:buying/widget/textwidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'authPorvider.dart';


class SignUpScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        backgroundColor: blackColor,
        title: largeText(title: 'Sign Up')
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset('assets/applogo.svg'),

              textFormField(
                  context: context,
                  text: "Name",
                  controller: nameController,
                  hint: 'Enter Name', obscuretext: false),
              textFormField(
                  context: context,
                  text: "Email",
                  controller: emailController,
                  hint: 'Enter Email', obscuretext: false),
              textFormField(
                  context: context,
                  text: "Password",
                  controller: passwordController,
                  hint: 'Enter Password', obscuretext: true),
              textFormField(
                  context: context,
                  text: "Confirm Password",
                  controller: confirmPasswordController,
                  hint: 'Confirm Password', obscuretext: true),
              SizedBox(height: 80),

              Container(
                width: MediaQuery.of(context).size.width*0.6,

                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      backgroundColor: goldenColor

                  ),
                  onPressed: () async {
                    try {
                      await userProvider.signUp(
                        nameController.text,
                        emailController.text,
                        passwordController.text,
                        confirmPasswordController.text,
                      ).then((response) => {
                      // Check if the login was successful
                      if (response.message == 'Successfully registered.') {
                // Assuming you have the user data available from the login response
                //                     int userId = response1.data.id;
                // Navigate to the SubscriptionScreen with the userId
                        Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SubscriptionScreen(userId: response.data.id),
                        ),
                      ),
                    } else {
                // Handle unsuccessful login, show a snackbar, etc.
                    ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                    content: Text('Login failed. Please check your credentials.'),
                    ),
                    ),
                    }

                      });
                    } catch (e) {
                // Handle errors, e.g., show a snackbar with the error message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Failed to login. Please try again.'),
                        ),
                      );
                    }
                  },
                  child: normalText(title: 'Sign Up', )
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    normalText(title: 'If u have account, then ', textSize: 12.0),
                    SizedBox(width: 5,),
                    InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));

                        },
                        child: normalText(textSize: 13.0, title: 'Login', color: goldenColor)
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




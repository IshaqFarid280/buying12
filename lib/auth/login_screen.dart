import 'package:buying/auth/authPorvider.dart';
import 'package:buying/auth/signupscreen.dart';
import 'package:buying/consts/colors.dart';
import 'package:buying/main.dart';
import 'package:buying/subscription_Screens/premiuim_buy.dart';
import 'package:buying/widget/textwidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';


class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: largeText(title: 'Login')
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
                  text: "Email",
                  controller: emailController,
                  hint: 'Email', obscuretext: false),
              textFormField(
                  context: context,
                  text: "Password",
                  controller: passwordController,
                  hint: 'Password', obscuretext: true),

              SizedBox(height: 100),
              Container(
                width: MediaQuery.of(context).size.width*0.6,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    backgroundColor: goldenColor

                  ),
                  onPressed: () async {
                    try {
                      final response = await userProvider.login(
                        emailController.text,
                        passwordController.text,
                      );
                      // Check if the login was successful
                      if (response.message == 'Successfully login.') {
                        print('userId: ${response.data.id}');
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SubscriptionScreen(userId: response.data.id),
                            ));
                      } else {
                        // Handle unsuccessful login, show a snackbar, etc.
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Login failed. Please check your credentials.'),
                          ),
                        );
                      }
                    } catch (e) {
                      // Handle errors, e.g., show a snackbar with the error message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Failed to login. Please try again.'),
                        ),
                      );
                    }
                  },
                  child: normalText(title: 'Login', )
                ),
              ),
              SizedBox(height: 5,),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    normalText(title: 'If u have account, then ', textSize: 12.0),
                    SizedBox(width: 5,),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));

                      },
                      child: normalText(textSize: 13.0, title: 'SignUp', color: goldenColor)
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

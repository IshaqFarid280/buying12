import 'package:buying/auth/login_screen.dart';
import 'package:buying/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../premium_buy_screens/premiuim_buy.dart';
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
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            TextFormField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Confirm Password'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
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
                    Navigator.push(
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
              child: Text('Sign Up'),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('If u dont have account, ',  style: TextStyle(
                      fontSize: 12
                  ),),
                  InkWell(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));

                    },
                    child: Text('Sign Up', style: TextStyle(
                      fontSize: 12,
                      color: Colors.purple
                    ),),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}




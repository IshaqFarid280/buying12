import 'package:buying/auth/authPorvider.dart';
import 'package:buying/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../premium_buy_screens/premiuim_buy.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  final response = await userProvider.login(
                    emailController.text,
                    passwordController.text,
                  );
                  // Check if the login was successful
                  if (response.message == 'Successfully login.') {
                    print('userId: ${response.data.id}');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SubscriptionScreen(userId: response.data.id),
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
              child: Text('Login'),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'If u have account, then',
                    style: TextStyle(fontSize: 12),
                  ),
                  InkWell(
                    onTap: () async {
                      try {
                         await userProvider
                            .login(
                              emailController.text,
                              passwordController.text,
                            )
                            .then((response) => {
// Check if the login was successful
                                  if (response.message == 'Successfully login.')
                                    {
// Assuming you have the user data available from the login response
//                     int userId = response1.data.id;

// Navigate to the SubscriptionScreen with the userId
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              SubscriptionScreen(
                                                  userId: response.data.id),
                                        ),
                                      ),
                                    }
                                  else
                                    {
// Handle unsuccessful login, show a snackbar, etc.
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'Login failed. Please check your credentials.'),
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
                    child: Text(
                      'Sign in',
                      style: TextStyle(fontSize: 12, color: Colors.purple),
                    ),
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

import 'package:buying/auth/login_screen.dart';
import 'package:buying/consts/colors.dart';
import 'package:buying/screens/routinescreen/days_screen/days_screen.dart';
import 'package:buying/screens/routinescreen/user_program_screen/user_program_provider.dart';
import 'package:buying/widget/textwidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';


class RoutineScreen extends StatelessWidget {
  final int? userId;
  const RoutineScreen({super.key, required this.userId});
  @override
  Widget build(BuildContext context) {

    final programProvider = Provider.of<UserProgramProvider>(context);
    // print('User Id from Program Screen: ${userId.toString()}');
    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: blackColor,
        title: largeText(title: 'Routine Screen', color: whiteColor),
        actions: [
          Container(
            child: normalText(title: userId.toString()),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Consumer<UserProgramProvider>(
        builder: (context, provider, child) {
          return FutureBuilder(
            future: provider.fetchPrograms(userId: userId!),
            builder: (context, snapshot) {
              if (provider.programs.isEmpty) {
                return Center(
                  child: CircularProgressIndicator(),
                ); // Loading indicator while waiting for the API response
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                return ListView.builder(
                  itemCount: programProvider.programs.length,
                  itemBuilder: (context, index) {
                    final program = programProvider.programs[index];
                    return ListTile(
                      onTap: () {
                        String successMessage = programProvider.message;
                        if (successMessage == "Successfully retrieved.") {
                          print('Print Success message: $successMessage');
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => DaysScreen(
                                programId: program.id,
                                userId: userId,
                                programName: program.name,
                              ),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(builder: (context) => LoginScreen()),
                          );
                        }
                      },
                      tileColor: listTileColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      title: listTileText(title: program.name),
                      subtitle: listTileText(title: 'ID: ${program.id}'),

                    );
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}

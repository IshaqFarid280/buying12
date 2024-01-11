import 'package:buying/consts/colors.dart';
import 'package:buying/screens/routinescreen/days_exercise_screen/days_exercise_provider.dart';
import 'package:buying/screens/routinescreen/days_exercise_screen/days_exercise_screen.dart';
import 'package:buying/screens/routinescreen/days_screen/add_day.dart';
import 'package:buying/screens/routinescreen/days_screen/days_provider.dart';
import 'package:buying/widget/floating_action_button.dart';
import 'package:buying/widget/textwidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DaysScreen extends StatelessWidget {
  final int? programId;
  final int? userId;
  final String? programName;

  const DaysScreen({required this.programId, required this.userId, this.programName});

  @override
  Widget build(BuildContext context) {
    final daysProvider = Provider.of<DayProvider>(context);
    // print('Program Id from Program Screen: ${programId.toString()}');
    // print('user  Id from Program Screen: ${userId.toString()}');
    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        backgroundColor: blackColor,
        title: normalText(title: '$programName'),
        actions: [
          normalText(title: programId.toString()),
          SizedBox(width: 10,),
        ],
      ),
      floatingActionButton: CustomFloatingAction(onPressed: () {
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) => PostDayScreen(
                  programId: programId!,

                  userId: userId!,
                )));
      }),
      body:  Consumer<DayProvider>(
        builder: (context, provider, child) {
          return FutureBuilder(
            future: provider.fetchDays(programId: programId.toString(), userId: userId.toString()),
            builder: (context, snapshot) {
              if (daysProvider.days.isEmpty) {
                return Center(
                  child: CircularProgressIndicator(),
                ); // Loading indicator while waiting for the API response
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('day screen Error: ${snapshot.error}'),
                );
              } else {
                return ListView.builder(
                  itemCount: provider.days.length,
                  itemBuilder: (context, index) {
                    final program = provider.days[index];
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) =>
                                    DaysExerciseScreen(daysId: int.parse(program.daysid.toString()), userId: int.parse(userId.toString()), dayname: program.days,)));
                      },
                      tileColor: listTileColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      title: listTileText(title: program.days),
                      subtitle: listTileText(title: 'Days ID: ${program.daysid}'),

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

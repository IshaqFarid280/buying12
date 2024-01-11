import 'package:buying/consts/colors.dart';
import 'package:buying/screens/categoryscreen/category_screen.dart';
import 'package:buying/screens/routinescreen/days_exercise_screen/days_exercise_provider.dart';
import 'package:buying/screens/routinescreen/setscreen/sets_screen.dart';
import 'package:buying/widget/floating_action_button.dart';
import 'package:buying/widget/textwidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DaysExerciseScreen extends StatelessWidget {
  final int? daysId;
  final int? userId;
  final String? dayname;
  const DaysExerciseScreen(
      {super.key,
      required this.daysId,
      required this.userId,
      required this.dayname});

  @override
  Widget build(BuildContext context) {
    // print('User id: $userId');
    // print('Days id: $daysId');

    final dayexerciseProvider = Provider.of<DayExerciseProvider>(context);
    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        backgroundColor: blackColor,
        title: normalText(title: dayname.toString()),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: whiteColor,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          Column(
            children: [
              normalText(title: 'User id: $userId', textSize: 12.0),
              normalText(title: 'Day id: $daysId'),
            ],
          ),
        ],
      ),
      floatingActionButton: CustomFloatingAction(
        onPressed: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => CategoryScreen(
                        userid: userId.toString(),
                    isDayExercises: true,
                        dayid: daysId.toString(),
                      )));
        },
      ),
      body: Consumer<DayExerciseProvider>(
        builder: (context, provider, child) {
          return FutureBuilder(
            future: provider.fetchDayExercises(
                userId: int.parse(userId.toString()),
                dayId: int.parse(daysId.toString())),
            builder: (context, snapshot) {
              if (dayexerciseProvider.dayExercises.isEmpty) {
                return Center(
                  child: CircularProgressIndicator(),
                ); // Loading indicator while waiting for the API response
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                // Use provider.dayExercises to display the data
                return ListView.builder(
                  itemCount: provider.dayExercises.length,
                  itemBuilder: (context, index) {
                    final dayExercise = dayexerciseProvider.dayExercises[index];
                    return ListTile(
                      tileColor: listTileColor,
                      trailing: CircleAvatar(
                        child: Text(dayExercise.id.toString()),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => ExerciseSetsScreen(
                                  exerciseName: dayExercise.exerciseName,
                                  exerciseId: dayExercise.id.toString(),
                                  userId: int.parse(userId.toString())),
                            ));
                      },
                      title: normalText(
                          title: dayExercise.exerciseName, textSize: 18.0),
                      // subtitle: normalText(
                      //     title: dayExercise.exerciseDescription,
                      //     textSize: 12.0),

                      subtitle: Text(
                        dayExercise.exerciseDescription,

                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      leading: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: greyColor,
                          ),
                          width: MediaQuery.of(context).size.width * 0.15,
                          height: MediaQuery.of(context).size.height * 0.15,
                          child: Image.network(dayExercise.exerciseImage)),
                      // Other widget properties...
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

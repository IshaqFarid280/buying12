import 'package:buying/consts/colors.dart';
import 'package:buying/screens/routinescreen/setscreen/sets_provider.dart';
import 'package:buying/widget/custom_button.dart';
import 'package:buying/widget/custom_indicator.dart';
import 'package:buying/widget/custom_leading.dart';
import 'package:buying/widget/custom_slider.dart';
import 'package:buying/widget/textwidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../widget/floating_action_button.dart';

class ExerciseSetsScreen extends StatefulWidget {
  final String exerciseId;
  final int? userId;
  final String exerciseName;
  ExerciseSetsScreen(
      {required this.exerciseName,
      required this.exerciseId,
      required this.userId});

  @override
  State<ExerciseSetsScreen> createState() => _ExerciseSetsScreenState();
}

class _ExerciseSetsScreenState extends State<ExerciseSetsScreen> {
  late TextEditingController kgController;
  late TextEditingController repsController;

  @override
  void initState() {
    super.initState();
    kgController = TextEditingController();
    repsController = TextEditingController();
  }

  @override
  void dispose() {
    kgController.dispose();
    repsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dayExercisesSetsProvider = Provider.of<SetProvider>(context);
    return Scaffold(
      backgroundColor: blackColor,
      floatingActionButton: CustomFloatingAction(onPressed: () {
        _showAddSetBottomSheet(
          context,
        );
      }),
      appBar: AppBar(
        backgroundColor: blackColor,
        leading: const CustomLeading(),
        title: largeText(title: '${widget.exerciseName.toUpperCase()} Sets'),
      ),
      body: FutureBuilder(
          future: dayExercisesSetsProvider.fetchExerciseSets(
              exerciseId: widget.exerciseId, userId: widget.userId),
          builder: (context, snapshot) {
            if (dayExercisesSetsProvider.exerciseSets.isEmpty) {
              return Center(child: largeText(title: 'Add some Sets'));
            } else if (dayExercisesSetsProvider.exerciseSets.isNotEmpty) {
              return ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: dayExercisesSetsProvider.exerciseSets.length,
                itemBuilder: (context, index) {
                  final exerciseSet =
                      dayExercisesSetsProvider.exerciseSets[index];
                  return CustomSlider(
                    deleteOnPressed: (context) {
                      dayExercisesSetsProvider.deleteExerciseSet(
                          setId: dayExercisesSetsProvider.exerciseSets[index].id
                              .toString());
                    },
                    editOnPressed: (context) {
                      _showUpdateSetBottomSheet(
                          context: context,
                          setId: dayExercisesSetsProvider.exerciseSets[index].id
                              .toString(),
                          previousKg:
                              dayExercisesSetsProvider.exerciseSets[index].kg,
                          previousReps: dayExercisesSetsProvider
                              .exerciseSets[index].reps);
                    },
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      tileColor: listTileColor,
                      title: Row(
                        children: [
                          smallText(
                              title: 'set ${index + 1}', color: whiteColor),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.2,
                          ),
                          smallText(
                              title: exerciseSet.kg,
                              textSize: 16.0,
                              color: buttonColors),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.02,
                          ),
                          smallText(title: 'kg'),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.04,
                          ),
                          smallText(title: 'x', color: iconColor),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.04,
                          ),
                          smallText(
                              title: exerciseSet.reps,
                              textSize: 16.0,
                              color: buttonColors),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.02,
                          ),
                          smallText(title: 'reps'),
                        ],
                      ),
                      trailing: normalText(title: exerciseSet.id.toString()),
                      // Add more details as needed
                    ),
                  );
                },
              );
            } else {
              return const CustomIndicator();
            }
          }),
    );
  }

  Future<void> _showAddSetBottomSheet(BuildContext context) async {
    final kgItems = List.generate(500, (index) => (index + 1).toString());
    final repsItems = List.generate(50, (index) => (index + 1).toString());
    int? selectedReps = 0;
    int? selectedKg = 0;

    await showModalBottomSheet<void>(
      elevation: 10,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: listTileColor,
          height: MediaQuery.of(context).size.height *
              0.35, // Adjust the height as needed
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: CupertinoPicker(
                      magnification: 1,
                      useMagnifier: true,
                      itemExtent: 70.0,
                      onSelectedItemChanged: (int index) {
                        print("Selected Reps: ${index + 1}");
                        selectedReps = index + 1;
                      },
                      children: List.generate(50, (index) {
                        return Center(
                            child: normalText(
                                title: ('${index + 1}  reps').toString(),
                                textSize: 20.0));
                      }),
                    ),
                  ),
                  Expanded(
                    child: CupertinoPicker(
                      useMagnifier: true,
                      itemExtent: 70.0,
                      onSelectedItemChanged: (int index) {
                        print("Selected Kg: ${index + 1}");
                        selectedKg = index + 1;
                      },
                      children: List.generate(50, (index) {
                        return Center(
                            child: normalText(
                                title: ('${index + 1}  kg').toString(),
                                textSize: 20.0));
                      }),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.02,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.8,
                child: CustomButton(
                  onTap: () async {
                    await Provider.of<SetProvider>(context, listen: false)
                        .postExerciseSet(
                      kg: [kgItems[int.parse(selectedKg.toString())]],
                      reps: [repsItems[int.parse(selectedReps.toString())]],
                      dayExerciseId: widget.exerciseId,
                      userID: widget.userId.toString(),
                      context: context,
                    );
                  },
                  title: 'Validate the Set',
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showUpdateSetBottomSheet(
      {required BuildContext context,
      required setId,
      required previousKg,
      required previousReps}) async {
    final kgItems = List.generate(500, (index) => (index + 1).toString());
    final repsItems = List.generate(500, (index) => (index + 1).toString());
    double selectedReps = double.parse(previousReps);
    double selectedKg = double.parse(previousKg);

    await showModalBottomSheet<void>(
      elevation: 10,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: listTileColor,
          height: MediaQuery.of(context).size.height *
              0.35, // Adjust the height as needed
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: CupertinoPicker(
                      magnification: 1,
                      useMagnifier: true,
                      itemExtent: 70.0,
                      onSelectedItemChanged: (int index) {
                        print("Selected Reps: ${index + 1}");
                        selectedReps = index + 1;
                      },
                      children: List.generate(50, (index) {
                        return Center(
                            child: normalText(
                                title: ('${index + 1}  reps').toString(),
                                textSize: 20.0));
                      }),
                      scrollController: FixedExtentScrollController(
                          initialItem: selectedReps.toInt() - 1),
                    ),
                  ),
                  Expanded(
                    child: CupertinoPicker(
                      useMagnifier: true,
                      itemExtent: 70.0,
                      onSelectedItemChanged: (int index) {
                        print("Selected Kg: ${index + 1}");
                        selectedKg = index + 1;
                      },
                      children: List.generate(50, (index) {
                        return Center(
                            child: normalText(
                                title: ('${index + 1}  kg').toString(),
                                textSize: 20.0));
                      }),
                      scrollController: FixedExtentScrollController(
                          initialItem: selectedKg.toInt() - 1),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.02,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.8,
                child: CustomButton(
                  onTap: () async {
                    print("Add Set Pressed");
                    await Provider.of<SetProvider>(context, listen: false)
                        .updateExerciseSet(
                      setId: setId,
                      userId: widget.userId.toString(),
                      kg: [kgItems[selectedKg.toInt()]],
                      reps: [repsItems[selectedReps.toInt()]],
                      context: context,
                    );
                  },
                  title: 'Validate the Set',
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

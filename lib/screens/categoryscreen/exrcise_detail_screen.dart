import 'dart:io';
import 'dart:math';

import 'package:buying/consts/colors.dart';
import 'package:buying/widget/textwidgets.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../widget/buttons.dart';

class ExerciseDetailScreen extends StatelessWidget {
  final String exerciseName;
  final String exerciseDescription;
  final String exerciseGif;
  const ExerciseDetailScreen(
      {super.key,
      required this.exerciseName,
      required this.exerciseDescription,
      required this.exerciseGif});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        backgroundColor: blackColor,
        leading: LeadingIcon(),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height * 0.25,
              width: MediaQuery.sizeOf(context).width * 1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: listTileLeadingColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.43,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          largeText(
                            title: getImageTitleLine(exerciseName.toString(), 0),
                            color: whiteColor,
                            textSize: 20.0,
                          ),
                          SizedBox(height: 8),
                          largeText(
                            title: getImageTitleLine(exerciseName.toString(), 1),
                            color: goldenColor,
                            textSize: 18.0,
                          ),
                          SizedBox(height: 8),
                          largeText(
                            title: getImageTitleLine(exerciseName.toString(), 2),
                            color: whiteColor,
                            textSize: 18.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: exerciseGif != null && exerciseGif.isNotEmpty
                        ? Container(
                        margin: EdgeInsets.only(right: 5),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                        clipBehavior: Clip.antiAlias,
                        height: MediaQuery.sizeOf(context).height * 0.21,
                        width: MediaQuery.sizeOf(context).width * 0.45,
                        child: Lottie.asset(
                            exerciseGif,
                            repeat: true,
                            fit: BoxFit.cover
                        ))
                        : ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: MediaQuery.sizeOf(context).height * 0.22,
                          width: MediaQuery.sizeOf(context).width * 0.45,

                          margin: EdgeInsets.only(right: 8),
                          child: Image(

                            fit: BoxFit.cover,
                            image: FileImage(File(exerciseGif ?? '')),
                          ),
                        )),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.05,
            ),
            largeText(title: 'Description :'),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.02,
            ),
            smallText(title: exerciseDescription.toString(), textSize: 14.0),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.05,
            ),
          ],
        ),
      ),

    );
  }

  String getImageTitleLine(String? title, int lineIndex) {
    if (title == null) return '';
    final words = title.split(' ');

    final start = lineIndex * 2;
    if (start >= words.length) return ''; // Check if start index is out of bounds

    final end = (lineIndex + 1) * 2;
    return words.sublist(start, min(end, words.length)).join(' ');
  }
}


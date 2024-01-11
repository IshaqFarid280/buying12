
import 'package:buying/consts/colors.dart';
import 'package:buying/screens/routinescreen/days_screen/days_provider.dart';
import 'package:buying/widget/Custom_Text_feild.dart';
import 'package:buying/widget/custom_button.dart';
import 'package:buying/widget/custom_leading.dart';
import 'package:buying/widget/textwidgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class PostDayScreen extends StatefulWidget {
  final int programId;
  final int userId;
  PostDayScreen({required this.programId, required this.userId});
  @override
  _PostDayScreenState createState() => _PostDayScreenState();
}

class _PostDayScreenState extends State<PostDayScreen> {
  final TextEditingController _dayNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        backgroundColor: blackColor,
        leading: const CustomLeading(),
        title: largeText(title: 'Post Day'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
            CustomTextFeild(controller: _dayNameController, hintText: 'Add new day'),
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
            CustomButton(title: 'Add Days', onTap: (){
              final dayProvider = Provider.of<DayProvider>(context, listen: false);
              dayProvider.postDay(_dayNameController.text.toUpperCase(),widget.programId.toString(),context, widget.userId );
            })
          ],
        ),
      ),
    );
  }
}
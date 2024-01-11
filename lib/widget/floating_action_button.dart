
import 'package:buying/consts/colors.dart';
import 'package:flutter/material.dart';


class CustomFloatingAction extends StatelessWidget {
  final VoidCallback onPressed ;
   CustomFloatingAction({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: buttonColors,
      isExtended: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
        onPressed: onPressed,
      child:const Center(child:  Icon(Icons.loupe_outlined,color:whiteColor,size: 30,)),
    );
  }
}


// data_saver_on_outlined
// control_point_duplicate_outlined
// add_task_outlined
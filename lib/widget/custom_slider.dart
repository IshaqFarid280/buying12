import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../consts/colors.dart';

class CustomSlider extends StatelessWidget {
  CustomSlider({required this.child,required this.deleteOnPressed,required this.editOnPressed,this.key});
  final void Function(BuildContext) editOnPressed;
  final void Function(BuildContext)  deleteOnPressed;
  final Widget child ;
  final Key ? key;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        key:Key(key.toString()),
        child: Slidable(
            key: Key(key.toString()),
            endActionPane: ActionPane(
              motion:const StretchMotion(),
              children: [
                // settings option
                SlidableAction(
                    onPressed: editOnPressed,
                    backgroundColor: greyColor,
                    icon: Icons.edit
                ),
                // delete option
                SlidableAction(
                  autoClose:true,
                  onPressed: deleteOnPressed,
                  backgroundColor: deleteColor,
                  icon: Icons.delete,
                  borderRadius:const BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
              ],
            ),
            child: child ),
      ),
    );
  }
}
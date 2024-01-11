
import 'package:buying/consts/colors.dart';
import 'package:flutter/material.dart';

class LeadingIcon extends StatelessWidget {
  IconData icon ;
  LeadingIcon({this.icon = Icons.arrow_back_ios_new});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: (){
          Navigator.pop(context);
        },
        child: Container(
          height: MediaQuery.sizeOf(context).height *0.01,
          width:MediaQuery.sizeOf(context).width *0.01,
          decoration: BoxDecoration(
            color: listTileColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(child: Icon(icon,color:listTileEditColor,),),
        ),
      ),
    );
  }
}

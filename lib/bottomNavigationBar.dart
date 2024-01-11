import 'package:buying/auth/login_screen.dart';
import 'package:buying/consts/colors.dart';
import 'package:buying/screens/categoryscreen/category_screen_not_working.dart';
import 'package:buying/screens/profilescreen/profile_screen.dart';
import 'package:buying/screens/routinescreen/user_program_screen/user_program_screen.dart';
import 'package:buying/screens/timerscreen/timer_screen.dart';
import 'package:buying/screens/categoryscreen/category_screen.dart';
import 'package:buying/user_premium_info/user_info_update/user_info_update_screen.dart';
import 'package:buying/widget/exit_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavigationScreen extends StatefulWidget {
  final int? userId;
  const BottomNavigationScreen({super.key, this.userId});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  var _selectedindexx = 0 ;
  late List<Widget> screens;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    screens = [
      RoutineScreen(userId: widget.userId),
      CategoryScreen(userid: null, dayid: null,),
      TimerScreen(),
      ProfileScreen()
    ];
  }
  void _onItemTapped(int index) {
    if (index == 1) {
      // If the selected item is the CalenderScreen, navigate to a new screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CategoryScreen(userid: null, dayid: null,)),
      );
      print(index);}
    if (index == 2) {
      // If the selected item is the CalenderScreen, navigate to a new screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TimerScreen()),
      );
    }

    if (index == 3) {
      // If the selected item is the CalenderScreen, navigate to a new screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfileScreen()      ));
    }

  }


  @override
  Widget build(BuildContext context) {
  print('Bottom Navigation Bar${widget.userId.toString()}');
    return WillPopScope(
      onWillPop:  () async {
        showDialog(
            barrierDismissible: false,
            context: context, builder: (context)=> exitDialog(context));
        return false;
      },
      child: Scaffold(
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            highlightColor: transparentColor,
            splashColor: transparentColor,
            hoverColor: transparentColor,
          ),
          child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: listTileColor,
              unselectedItemColor: listTileColor,
              backgroundColor: blackColor,
              onTap: _onItemTapped,
              items: [
                BottomNavigationBarItem(icon: SvgPicture.asset('assets/svg/homeicon.svg', width: 20,),label: '',),
                BottomNavigationBarItem(icon: SvgPicture.asset('assets/svg/dumbel.svg'), label: ''),
                BottomNavigationBarItem(icon: SvgPicture.asset('assets/svg/clock.svg'), label: ''),
                BottomNavigationBarItem(icon: SvgPicture.asset('assets/svg/calnder.svg'),label: ''),
              ]
          ),
        ),
        body: screens[_selectedindexx],
      ),
    );
  }
}

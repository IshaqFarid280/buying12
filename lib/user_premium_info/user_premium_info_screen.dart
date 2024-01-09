import 'package:buying/user_premium_info/user_premium_infomation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'user_info_update/user_info_update_screen.dart';

class UserFromScreen extends StatefulWidget {
  final int userId;
  final double height;
  final double weight;
  final String gender;
  final int age;
  final List<String> goals;
  final String experience;
  final String equipment;
  final List<String> interests;
  final List<String> focus;
  UserFromScreen(
      {required this.userId,
      required this.height,
      required this.weight,
      required this.gender,
      required this.age,
      required this.goals,
      required this.experience,
      required this.equipment,
        required this.interests,
        required this.focus,
      });

  @override
  _UserFromScreenState createState() => _UserFromScreenState();
}

class _UserFromScreenState extends State<UserFromScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> UserInfoUpdateScreen(
          userId: widget.userId,
          gender: widget.gender.toString(),
          height: widget.height,
          weight: widget.weight,
          age: widget.age,
          goals: widget.goals.toString().split(','),
          experience: widget.experience,
          equipment: widget.equipment,
          interests: widget.interests.toString().split(','),
          focus: widget.focus.toString().split(','),
        )));
      },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('User Information Input'),
        actions: [
          IconButton(onPressed: (){
            final userInformationProvider = Provider.of<UserInformationProvider>(context, listen: false);
            userInformationProvider.deleteUserInformation(widget.userId);

          }, icon: Icon(Icons.delete)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display user information
              Text('User ID: ${widget.userId}'),
              Text('Height: ${widget.height}'),
              Text('Weight: ${widget.weight}'),
              Text('Gender: ${widget.gender}'),
              Text('Age: ${widget.age}'),
              Text('Goals: ${widget.goals.join(', ')}'),
              Text('Experience: ${widget.experience}'),
              Text('Equipment: ${widget.equipment}'),
              Text('Interests: ${widget.interests.join(', ')}'),
              Text('Focus: ${widget.focus.join(', ')}'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final userInformationProvider = Provider.of<UserInformationProvider>(context, listen: false);
                  final userInformation = UserInformation(
                    userId: widget.userId.toString(),
                    gender: widget.gender.toString(),
                    height: widget.height.toStringAsFixed(1),
                    weight: widget.weight.toStringAsFixed(1),
                    age: widget.age.toString(),
                    goal: widget.goals.toString().split(','),
                    experience: widget.experience,
                    equipment: widget.equipment,
                    interest: widget.interests.toString().split(','),
                    focus: widget.focus.toString().split(','),
                  );
                  userInformationProvider.postUserInformation(userInformation);
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

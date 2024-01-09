import 'package:buying/consts/colors.dart';
import 'package:buying/screens/routinescreen/routine_premium_provider.dart';
import 'package:buying/widget/buttons.dart';
import 'package:buying/widget/textwidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

// class RoutineScreen extends StatelessWidget {
//   final int? userId;
//   const RoutineScreen({super.key, required this.userId});
//
//   @override
//   Widget build(BuildContext context) {
//     print(userId.toString());
//     return Scaffold(
//       backgroundColor: blackColor,
//       appBar: AppBar(
//         backgroundColor: blackColor,
//
//         title: largeText(title: 'Routine Screen', color: whiteColor),
//         actions: [
//           Container(
//             child: normalText(title: userId.toString()),
//           )
//         ],
//       ),
//       body: FutureBuilder(
//
//       ),
//
//     );
//   }
// }

class RoutineScreen extends StatelessWidget {
  final int? userId;
  const RoutineScreen({super.key, required this.userId});
  @override
  Widget build(BuildContext context) {
    print(userId.toString());
       return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(backgroundColor: blackColor,
        title: largeText(title: 'Routine Screen', color: whiteColor),
          actions: [
          Container(
            child: normalText(title: userId.toString()),
          ),
            SizedBox(width: 10,),
        ],

      ),
         body: Consumer<UserProgramProvider>(
          builder: (context, provider, child) {
            return FutureBuilder(
              future: provider.fetchUserPrograms(userId!),
              builder: (context, snapshot) {
                if (!provider.isFetched) {
                  // Trigger fetching only if data is not fetched yet
                  provider.triggerFetch(userId!);
                }
                if (provider.userPrograms.isEmpty) {
                  return Center(
                    child: CircularProgressIndicator(),
                  ); // Loading indicator while waiting for the API response
                }
                else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  return ListView.builder(
                    itemCount: provider.userPrograms.length,
                    itemBuilder: (context, index) {
                      final userProgram = provider.userPrograms[index];
                      print(provider.userPrograms[index].name);
                      return Container(
                        margin: EdgeInsets.all(8),
                        color: greyColor,
                        child: ListTile(

                          title: normalText(title: userProgram.name),
                          leading: Icon(Icons.kebab_dining, color: whiteColor,),

                        ),
                      );
                    },
                  );
                }
              },
            );
          },
               ),


       );}
}

// import 'package:buttons_tabbar/buttons_tabbar.dart';
// import 'package:buying/auth/signupscreen.dart';
// import 'package:buying/screens/categoryscreen/add_category.dart';
// import 'package:buying/screens/categoryscreen/add_exercises.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_speed_dial/flutter_speed_dial.dart';
// import 'package:provider/provider.dart';
// import 'CategoryProvider.dart';
//
// class CategoryScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     print('Building YourHomePage');
//
//     CategoryProvider categoryProvider = Provider.of<CategoryProvider>(context);
//
//     return DefaultTabController(
//       length: categoryProvider.categoriesLength,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Your App'),
//         ),
//         body: FutureBuilder(
//           future: categoryProvider.fetchCategories(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               print('FutureBuilder: Waiting for data');
//                   List<Category> categories = categoryProvider.categories;
//
//                   if (categories.isEmpty) {
//                     return Text('No categories available.');
//                   }
//
//                   List<String> categoryNames =
//                   categories.map((category) => category.name).toList();
//
//                   return Column(
//                     children: [
//                       ButtonsTabBar(
//                         tabs: categoryNames
//                             .map(
//                               (name) => Tab(
//                             child: Container(
//                               height: MediaQuery.of(context).size.height * 0.06,
//                               width: MediaQuery.of(context).size.width * 0.18,
//                               child: Center(child: Text(name)),
//                             ),
//                           ),
//                         )
//                             .toList(),
//                         backgroundColor: Colors.amberAccent,
//                         borderWidth: 1,
//                         borderColor: Colors.black,
//                         labelStyle: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         unselectedLabelStyle: TextStyle(
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Expanded(
//                         child: TabBarView(
//                           children: categoryNames.map(
//                                 (name) {
//                               Category selectedCategory = categories.firstWhere(
//                                       (category) => category.name == name);
//
//                               return FutureBuilder(
//                                 future: categoryProvider
//                                     .fetchCategoryExercises(selectedCategory.id),
//                                 builder: (context, snapshot) {
//                                  // print('FutureBuilder: Fetching exercises for category ID: ${selectedCategory.id}');
//                                   if (categoryProvider.exercises.isNotEmpty) {
//                                  //   print('Exercises available: ${categoryProvider.exercises.length}');
//                                     List<Exercise> exercises = categoryProvider.exercises;
//                                       return ListView.builder(
//                                         itemCount: exercises.length,
//                                         itemBuilder: (context, index) {
//                                           Exercise exercise = exercises[index];
//                                           return ListTile(
//                                             leading: ClipRRect(
//                                               borderRadius: BorderRadius.circular(8.0),
//                                               child: Image.network(
//                                                 exercise.gifUrl,
//                                                 fit: BoxFit.cover,
//                                                 width: 50,
//                                                 height: 50,
//                                               ),
//                                             ),
//                                             title: Text(
//                                               exercise.name,
//                                               maxLines: 1,
//                                               overflow: TextOverflow.ellipsis,
//                                             ),
//                                             subtitle: Text(
//                                               exercise.description,
//                                               style: TextStyle(),
//                                               maxLines: 1,
//                                               overflow: TextOverflow.ellipsis,
//                                             ),
//                                           );
//                                         },
//                                       );
//                                   } else if (snapshot.hasError) {
//                                     print('Error: ${snapshot.error}');
//                                     return Text('Error: ${snapshot.error}');
//                                   } else {
//                                     print('No exercises available for category ID: ${selectedCategory.id}');
//                                     return Text('Add Some EXERCISE');
//                                   }
//                                 },
//                               );
//                             },
//                           ).toList(),
//                         ),
//                       ),
//                     ],
//                   );
//
//             }
//             else if (snapshot.hasError) {
//               print('FutureBuilder: Error: ${snapshot.error}');
//               return Text('Error: ${snapshot.error}');
//             } else {
//               print('FutureBuilder: No Categories available');
//               return Text('Add Some Categories');
//             }
//           },
//         ),
//         floatingActionButton: buildSpeedDial(context),
//       ),
//     );
//   }
// }
//
//
//
// Widget buildSpeedDial(BuildContext context) {
//   return SpeedDial(
//     animatedIcon: AnimatedIcons.ellipsis_search,
//     animatedIconTheme: IconThemeData(size: 22.0),
//     backgroundColor: Colors.yellow,
//     visible: true,
//     curve: Curves.bounceIn,
//     children: [
//       SpeedDialChild(
//         child: Icon(Icons.add),
//         backgroundColor: Colors.green,
//         onTap: () {
//           Navigator.push(
//             context,
//             CupertinoPageRoute(builder: (context) => AddCategoryScreen()),
//           );
//         },
//         label: 'Add Category',
//         labelStyle: TextStyle(fontSize: 18.0),
//         labelBackgroundColor: Colors.green,
//       ),
//       SpeedDialChild(
//         child: Icon(Icons.add),
//         backgroundColor: Colors.orange,
//         onTap: () {
//           Navigator.push(
//             context,
//             CupertinoPageRoute(
//               builder: (context) => AddExerciseScreen(categoryId: '1'),
//             ),
//           );
//         },
//         label: 'Add Exercises',
//         labelStyle: TextStyle(fontSize: 18.0),
//         labelBackgroundColor: Colors.orange,
//       ),
//     ],
//   );
// }

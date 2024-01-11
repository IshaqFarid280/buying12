import 'package:buying/consts/colors.dart';
import 'package:buying/premium_api_links/api_controller.dart';
import 'package:buying/screens/categoryscreen/add_category.dart';
import 'package:buying/screens/categoryscreen/add_exercises.dart';
import 'package:buying/screens/categoryscreen/exerciseProvider.dart';
import 'package:buying/screens/categoryscreen/exrcise_detail_screen.dart';
import 'package:buying/widget/textwidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';

class Category {
  final int id;
  final String name;

  Category({required this.id, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Exercise {
  final int id;
  final String exerciseName;
  final String exerciseDescription;
  final String exerciseGif;

  Exercise({
    required this.id,
    required this.exerciseName,
    required this.exerciseDescription,
    required this.exerciseGif,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'],
      exerciseName: json['exercise_name'],
      exerciseDescription: json['exercise_description'],
      exerciseGif: json['exercise_gif'],
    );
  }
}

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<List<Category>> getCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/category'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['data'];
      return data.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<void> addCategory(String categoryName) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiServices.basicUrl}/category/store'),
        body: {'name': categoryName},
      );

      final responseData = json.decode(response.body);

      if (response.statusCode == 200 && responseData['message'] != null) {
        print('Category created successfully');
      } else {
        print('Failed to create category: ${responseData['message']}');
        throw Exception('Failed to create category');
      }
    } catch (error) {
      print('Error creating category: $error');
      throw Exception('Failed to create category');
    }
  }

  Future<List<Exercise>> getExercisesByCategory(int categoryId) async {
    final response = await http.get(Uri.parse('$baseUrl/category/$categoryId'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body)['data'];
      List<dynamic> exercisesData = data['exercises'];
      return exercisesData.map((json) => Exercise.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load exercises for the category');
    }
  }
}

class CategoryProviderr extends ChangeNotifier {
  int _selectedCategoryId = -1;

  int _categoriesLength = 0;

  int get selectedCategoryId => _selectedCategoryId;
  int get categoriesLength => _categoriesLength;
  int _reloadCount = 0;

  int get reloadCount => _reloadCount;

  void reloadScreen() {
    _reloadCount++;
    notifyListeners();
  }

  set selectedCategoryId(int value) {
    _selectedCategoryId = value;
    notifyListeners();
  }
}

class CategoryScreen extends StatefulWidget {
  final String? userid;
  final String? dayid;
  final bool isDayExercises;
  CategoryScreen({
    required this.userid,
    required this.dayid,
    this.isDayExercises = false,
  });
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<CategoryProviderr>(context, listen: false).reloadScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Categories row
          Container(
            height: 50.0,
            child: Consumer<CategoryProviderr>(
              builder: (context, categoryProvider, _) {
                return FutureBuilder<List<Category>>(
                  future:
                      ApiService(baseUrl: ApiServices.basicUrl).getCategories(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      List<Category> categories = snapshot.data!;

                      if (categoryProvider.selectedCategoryId == -1 &&
                          categories.isNotEmpty) {
                        categoryProvider.selectedCategoryId =
                            categories.first.id;
                      }

                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              categoryProvider.selectedCategoryId =
                                  categories[index].id;
                            },
                            child: Container(
                              padding: EdgeInsets.all(4.0),
                              margin: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color:
                                        categoryProvider.selectedCategoryId ==
                                                categories[index].id
                                            ? Colors.blue
                                            : Colors.black),
                                color: categoryProvider.selectedCategoryId ==
                                        categories[index].id
                                    ? Colors.yellow
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Text(categories[index].name),
                            ),
                          );
                        },
                      );
                    }
                  },
                );
              },
            ),
          ),
          // Exercises section
          exerciselist(
            userid: widget.userid,
            dayid: widget.dayid,
            isDayExercises: widget.isDayExercises,
          ),
        ],
      ),
      floatingActionButton: buildSpeedDial(context),
    );
  }
}

class exerciselist extends StatefulWidget {
  final String? userid;
  final String? dayid;
  final bool isDayExercises;

  const exerciselist({
    super.key,
    required this.userid,
    required this.dayid,
    this.isDayExercises = false,
  });

  @override
  State<exerciselist> createState() => _exerciselistState();
}

class _exerciselistState extends State<exerciselist> {
  @override
  Widget build(BuildContext context) {
    final exerciseProvider = Provider.of<ExerciseProvider>(context);
    return Expanded(
      child: Consumer<CategoryProviderr>(
        builder: (context, categoryProvider, _) {
          return FutureBuilder<List<Exercise>>(
            future: ApiService(baseUrl: ApiServices.basicUrl)
                .getExercisesByCategory(categoryProvider.selectedCategoryId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                List<Exercise> exercises = snapshot.data!;
                return ListView.builder(
                  itemCount: exercises.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => ExerciseDetailScreen(
                                    exerciseName: exercises[index].exerciseName,
                                    exerciseDescription:
                                        exercises[index].exerciseDescription,
                                    exerciseGif:
                                        exercises[index].exerciseGif)));
                      },
                      trailing: widget.isDayExercises
                          ? IconButton(
                              onPressed: () {
                                exerciseProvider.postDayExercise(
                                    dayId: widget.dayid,
                                    exerciseName: exercises[index].exerciseName,
                                    context: context,

                                    userId: widget.userid,
                                    exercisedescription: exercises[index].exerciseDescription,
                                    exerciseimageURL: exercises[index].exerciseGif);
                              },
                              icon: const Icon(
                                Icons.data_saver_on_outlined,
                                size: 35,
                              ),
                              color: buttonColors,
                            )
                          : Container(
                              height: 5,
                              width: 5,
                            ),
                      title: Row(
                        children: [
                          Text(exercises[index].exerciseName),
                          SizedBox(width: 5,),
                          normalText(title: 'dayId: ${widget.dayid.toString()}', color: blackColor, textSize: 12.0),
                        ],
                      ),
                      subtitle: Text(
                        exercises[index].exerciseDescription,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                            width: MediaQuery.of(context).size.width * 0.15,
                            height: MediaQuery.of(context).size.height * 0.15,
                            child: Image.network(
                              exercises[index].exerciseGif,
                              fit: BoxFit.cover,
                            )),
                      ),
                    );
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}

Widget buildSpeedDial(BuildContext context) {
  return SpeedDial(
    animatedIcon: AnimatedIcons.ellipsis_search,
    animatedIconTheme: IconThemeData(size: 22.0),
    backgroundColor: Colors.yellow,
    visible: true,
    curve: Curves.bounceIn,
    children: [
      SpeedDialChild(
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
        onTap: () {
          Navigator.push(
            context,
            CupertinoPageRoute(builder: (context) => AddCategoryScreen()),
          ).then((value) {
            Provider.of<CategoryProviderr>(context, listen: false)
                .reloadScreen();
          });
        },
        label: 'Add Category',
        labelStyle: TextStyle(fontSize: 18.0),
        labelBackgroundColor: Colors.green,
      ),
      SpeedDialChild(
        child: Icon(Icons.add),
        backgroundColor: Colors.orange,
        onTap: () {
          int selectedCategoryId =
              Provider.of<CategoryProviderr>(context, listen: false)
                  .selectedCategoryId;

          if (selectedCategoryId != -1) {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => AddExerciseScreen(
                    categoryId: selectedCategoryId.toString()),
              ),
            ).then((value) {
              Provider.of<CategoryProviderr>(context, listen: false)
                  .reloadScreen();
            });
          }
        },
        label: 'Add Exercises',
        labelStyle: TextStyle(fontSize: 18.0),
        labelBackgroundColor: Colors.orange,
      ),
    ],
  );
}

import 'dart:convert';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:buying/auth/signupscreen.dart';
import 'package:buying/premiium_all_exercises_categories/add_category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'CategoryProvider.dart';

class YourHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CategoryProvider categoryProvider = Provider.of<CategoryProvider>(context);

    return DefaultTabController(
      length: categoryProvider.categoriesLength,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Your App'),
          actions: [
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUpScreen(),
              ));
            }, icon: Icon(Icons.arrow_forward_ios))
          ],
        ),
        body: FutureBuilder(
          future: categoryProvider.fetchCategories(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return  Consumer<CategoryProvider>(
                builder: (context, categoryProvider, child) {
                  List<Category> categories = categoryProvider.categories;

                  if (categories.isEmpty) {
                    return Text('No categories available.');
                  }
                  // Extract category names for TabBar
                  List<String> categoryNames = categories.map((category) => category.name).toList();
                  return Column(
                    children: [
                      // Use the buttons_tabbar package to display category names
                      ButtonsTabBar(
                        tabs: categoryNames.map((name) => Tab(child: Container(
                          height: 30,
                          width: 30,
                          child: Column(
                            children: [
                              Text(name),
                            ],
                          ),
                        ),)).toList(),
                        backgroundColor: Colors.red,
                        borderWidth: 2,
                        borderColor: Colors.black,
                        labelStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        unselectedLabelStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),

                      ),
                      Expanded(
                        child: // Inside the TabBarView, replace the placeholder text with the actual content
                        TabBarView(
                          children: categoryNames.map((name) {
                            // Find the category object based on its name
                            Category selectedCategory = categories.firstWhere((category) => category.name == name);
                            // Display exercises for the selected category
                            return FutureBuilder(
                              future: categoryProvider.fetchCategoryExercises(selectedCategory.id), // Add a method to fetch exercises for a specific category
                              builder: (context, snapshot) {
                                List<Exercise>? exercises = snapshot.data;
                                if (exercises?.length != null) {
                                  // Replace this with the widget that displays the exercises for the category
                                    return ListView.builder(
                                      itemCount: exercises?.length,
                                      itemBuilder: (context, index) {
                                        Exercise exercise = exercises![index];
                                        return ListTile(
                                          leading: ClipRRect(
                                            borderRadius: BorderRadius.circular(8.0), // Adjust the border radius as needed
                                            child: Image.network(
                                              exercise.gifUrl,
                                              fit: BoxFit.cover, // Make the image fit cover
                                              width: 50, // Adjust the width as needed
                                              height: 50, // Adjust the height as needed
                                            ),
                                          ),
                                          title: Text(
                                            exercise.name,
                                            maxLines: 1, // Show the text in one line
                                            overflow: TextOverflow.ellipsis, // Display ellipsis if the text overflows
                                          ),
                                          subtitle: Text(
                                            exercise.description,
                                            style: TextStyle(),
                                            maxLines: 1, // Show the text in one line
                                            overflow: TextOverflow.ellipsis, // Display ellipsis if the text overflows
                                          ),
                                        );

                                      },
                                    );
                                } else if (exercises?.length == null) {
                                  return const Center(
                                    child: CircularProgressIndicator()
                                  );
                                } else {
                                  return Center(child: Text(snapshot.error.toString()),);
                                }
                              },
                            );
                          }).toList(),
                        ),

                      ),
                    ],
                  );
                },
              );
            }
            else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else  {
              return Text('Add Some Cateogries');
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, CupertinoPageRoute(builder: (context) => AddCategoryScreen()));
          },
          child: Text('+'),
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'CategoryProvider.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyAppp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => CategoryProvider(),
//       child: MaterialApp(
//         title: 'Your App Title',
//         home: YourHomePage(),
//       ),
//     );
//   }
// }

class YourHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CategoryProvider categoryProvider = Provider.of<CategoryProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your App'),
      ),
      body: FutureBuilder(
        future: categoryProvider.fetchCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Consumer<CategoryProvider>(
              builder: (context, categoryProvider, child) {
                List<Category> categories = categoryProvider.categories;

                return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  reverse: true,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(categories[index].name),
                      subtitle:Text(categories[index].id.toString()),
                      // Other details as needed
                    );
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Consumer<CategoryProvider>(
              builder: (context, categoryProvider, child) {
                List<Category> categories = categoryProvider.categories;

                return ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(categories[index].name),
                      // Other details as needed
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

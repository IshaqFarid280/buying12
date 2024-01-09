import 'package:buying/premiium_all_exercises_categories/CategoryProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCategoryScreen extends StatelessWidget {
  final TextEditingController _categoryController = TextEditingController();

  void addCategory(BuildContext context, String categoryName) async {
    try {
      // Get the instance of CategoryProvider
      CategoryProvider categoryProvider = Provider.of<CategoryProvider>(context, listen: false);

      // Call the addCategory method
      await categoryProvider.addCategory(categoryName);

      // Do any additional logic after successfully adding the category
    } catch (error) {
      // Handle the error
      print('Error adding category: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Category'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _categoryController,
              decoration: InputDecoration(
                labelText: 'Category Name',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Get the text from the TextFormField
                String categoryName = _categoryController.text.trim();

                // Call the addCategory method
                addCategory(context, categoryName);
              },
              child: Text('Add Category'),
            ),
          ],
        ),
      ),
    );
  }
}

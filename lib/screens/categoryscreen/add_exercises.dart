import 'dart:io';
import 'package:buying/screens/categoryscreen/exerciseProvider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddExerciseScreen extends StatefulWidget {
  final String categoryId;
  AddExerciseScreen({required this.categoryId});

  @override
  _AddExerciseScreenState createState() => _AddExerciseScreenState();
}

class _AddExerciseScreenState extends State<AddExerciseScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  File? imageFile;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Exercise'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Exercise Name'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Exercise Description'),
              maxLines: 4,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pick Image'),
            ),
            SizedBox(height: 16),
            imageFile != null
                ? Image.file(
              imageFile!,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            )
                : Container(),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {

                if (imageFile != null) {
                  Provider.of<ExerciseProvider>(context, listen: false).postExercise(
                    context: context,
                    categoryId: widget.categoryId,
                    name: nameController.text,
                    description: descriptionController.text,
                    imageFile: imageFile!,
                  );
                } else {
                  print('Please pick an image');
                }
              },
              child: Text('Post Exercise'),
            ),
          ],
        ),
      ),
    );
  }
}

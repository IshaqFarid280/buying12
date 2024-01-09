import 'dart:convert';
import 'dart:io';
import 'package:buying/premiium_all_exercises_categories/CategoryProvider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../premium_api_links/api_controller.dart';

class ExerciseProvider with ChangeNotifier {
  List<Exercise> _exercises = [];
  List<Exercise> get exercises => _exercises;

  Future<List<Exercise>> fetchExercises(int categoryId) async {
    print('Category id on which new exercise is created: $categoryId');
    final response = await http.get(Uri.parse('${ApiServices.getRelatedExercisesCategories}/$categoryId'));
    if (response.statusCode == 200) {
      print('Status Code: ${response.statusCode}');
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> exercisesData = responseData['data']['exercises'];
      print('Response data Code: ${response.body}');
      _exercises = exercisesData
          .map((exerciseData) => Exercise(
        id: exerciseData['id'],
        name: exerciseData['exercise_name'],
        description: exerciseData['exercise_description'],
        gifUrl: exerciseData['exercise_gif'],
        categoryId: int.parse(exerciseData['category_id'].toString()),
      ))
          .toList();
      notifyListeners();
      return _exercises; // Return the list of exercises
    } else {
      throw Exception('Failed to load exercises');
    }
  }

  Future<File?> pickImageFromGallery() async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        return File(pickedFile.path);
      }
    } catch (error) {
      print('Error picking image: $error');
      throw Exception('Failed to pick image');
    }
    return null;
  }

  Future<void> postExercise({required context , required String categoryId, required String name, required String description, required File imageFile,}) async {
    try {
      final request = http.MultipartRequest('POST', Uri.parse(ApiServices.postExercises))
        ..fields['category_id'] = categoryId
        ..fields['exercise_name'] = name
        ..fields['exercise_description'] = description
        ..files.add(http.MultipartFile(
          'exercise_gif',
          imageFile.readAsBytes().asStream(),
          imageFile.lengthSync(),
          filename: 'exercise_image.jpg', // Adjust the filename as needed
          // contentType: MediaType('image', 'jpeg','gif',), // Adjust the content type based on your file type
        ));
      final response = await http.Response.fromStream(await request.send());
      if (response.statusCode == 200) {
        // You can handle success as needed
        Navigator.pop(context);
        print('Exercise posted successfully');
      } else {
        // Handle errors if needed
        throw Exception('Failed to post exercise');
      }
    } catch (error) {
      // Handle exceptions if needed
      print('Error posting exercise: $error');
      throw Exception('Failed to post exercise');
    }
  }



  Future<void> deleteExercise({
    required int exerciseId,
  }) async {
    try {
      final response = await http.get(Uri.parse('${ApiServices.deleteExercise}/$exerciseId'));
      if (response.statusCode == 200) {
        // You can handle success as needed
        print('Exercise deleted successfully');
      } else {
        // Handle errors if needed
        throw Exception('Failed to delete exercise: ${response.body}');
      }
    } catch (error) {
      // Handle exceptions if needed
      print('Error deleting exercise: $error');
      throw Exception('Failed to delete exercise');
    }
  }

  Future<void> updateExerciseImageWithPicker({
    required BuildContext context,
    required int exerciseId,
    required String categoryId,
    required TextEditingController nameController,
    required TextEditingController descriptionController,
    required exerciseName,
    required exerciseDescription,
    required exerciseGifPath,
  }) async {
    try {
      // Initial values for name and description
      nameController.text = nameController.text;
      descriptionController.text = descriptionController.text;
      // Initialize variables to store the picked image
      File? newImageFile;
      // Show an updating alert dialog with TextFormFields
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title:const Text("Edit Exercise"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration:const  InputDecoration(labelText: 'Exercise Name'),
                    ),
                    TextFormField(
                      controller: descriptionController,
                      decoration:const InputDecoration(labelText: 'Exercise Description'),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            // Pick an image from the user's device
                            final pickedFile = await pickImageFromGallery();
                            if (pickedFile != null) {
                              setState(() {
                                newImageFile = File(pickedFile.path);
                              });
                            }else{
                              setState(() {
                                newImageFile = File(exerciseGifPath);
                              });
                            }
                          },
                          child: Text('Pick Image'),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            // Perform the update with the new values
                            if (newImageFile == null) {
                              setState(() {
                                newImageFile = File(exerciseGifPath);
                              });
                            }
                            final request = http.MultipartRequest('POST', Uri.parse('${ApiServices.updateExercise}/$exerciseId'))
                              ..fields['category_id'] = categoryId
                              ..fields['exercise_name'] = nameController.text == '' ? exerciseName.toString() : nameController.text
                              ..fields['exercise_description'] = descriptionController.text == '' ? exerciseDescription : descriptionController.text
                              ..files.add(http.MultipartFile(
                                'exercise_gif',
                                newImageFile!.readAsBytes().asStream(),
                                newImageFile!.lengthSync(),
                                filename: 'exercise_image.jpg',
                              ));
                            final response = await http.Response.fromStream(await request.send());
                            Navigator.pop(context); // Close the updating dialog
                            if (response.statusCode == 200) {
                              // Exercise image updated successfully
                              // You can handle success as needed
                              print('Exercise image updated successfully');
                            } else {
                              // Handle errors if needed
                              throw Exception('Failed to update exercise image: ${response.body}');
                            }
                          },
                          child:const Text('Update'),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      );
    } catch (error) {
      // Handle exceptions if needed
      print('Error updating exercise image: $error');
      throw Exception('Failed to update exercise image');
    }
  }


}


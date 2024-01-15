


class  ApiServices {
  static String  basicUrl = 'http://192.168.1.19:8000/api';
  static String  getAllCategories = '$basicUrl/category';

  static String  postAllCategories = '$basicUrl/category/store';
  static String  updateAllCategories = '$basicUrl/category/update';
  static String  deleteCategories = '$basicUrl/category/delete';
  static String  getRelatedExercisesCategories = '$basicUrl/category';


  // days exercises APis
  static String  getDayExercises = '$basicUrl/day_exercise';
  static String  postDayExercises = '$basicUrl/day_exercise';
  static String  updateDayExercises = '$basicUrl/day_exercise';  // after day/id ( you understand )
  static String  destroyDayExercises = '$basicUrl/day_exercise';  // after day/id/destroy ( you understand )


  // exercises related Apis
  static String postExercises = '$basicUrl/exercise/';
  static String  updateExercise = '$basicUrl/exercise/update';
  static String  deleteExercise = '$basicUrl/exercise/delete';

  // subscription APis
  static String  postPremiumData = '$basicUrl/subscription';
  static String  getPremiumData = '$basicUrl/subscription?user_id=4';

  //User information
  static String  postUserInfo = '$basicUrl/user_information';
  static String getUserDetailsProfileScreen = '$basicUrl/routine/details';
  static String  updateUsersInfo = '$basicUrl/user_information/update';
  static String  deleteUsersInfo = '$basicUrl/user_information/delete';
  // All User information
  static String  getAllUsersInfo = '$basicUrl/users_information';


  // days APis
  static String  getDay = '$basicUrl/day';
  static String  postDay_user_api = '$basicUrl/day';
  static String  postDay_admin_api = '$basicUrl/day';
  static String  updateDay = '$basicUrl/day';  // after day/id ( you understand )
  static String  destroyDay = '$basicUrl/day';  // after day/id/destroy ( you understand )

  static String  getSets = '$basicUrl/set';
  static String  postSets = '$basicUrl/set';
  static String  updateSets = '$basicUrl/set';  // after set/id ( you understand )
  static String  destroySets = '$basicUrl/set';  // after set/id/destroy ( you understand )




  // assign workout program
  static String  assignWorkoutProgram = '$basicUrl/program_assign';
  //get assigned program
  static String  getAssignWorkoutProgram = '$basicUrl/assigned_program';
  //get assigned days

  //get assigned days-exercises
  static String getAssignDaysExercise=  '$basicUrl/day_exercise';
  //?user_id=null&request_type=user

}
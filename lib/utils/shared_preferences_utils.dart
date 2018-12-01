import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';
import '../model/student.dart';
import 'dart:async';

class SharedPreferencesUtils {
  static Future<SharedPreferences> _sharedPreferences;

  SharedPreferencesUtils(){
    _initSharedPreferences();
  }

  _initSharedPreferences(){
    _sharedPreferences = SharedPreferences.getInstance();
  }

  logoutStudent(){
    _sharedPreferences.then((sharedPrefs) {
      sharedPrefs.clear();
    });
  }

  saveStudent(Student student){
    _sharedPreferences.then((sharedPrefs) {
      sharedPrefs.setString(Constants.studentName, student.studentName);
      sharedPrefs.setString(Constants.studentId, student.studentId);
      sharedPrefs.setInt(Constants.studentClass, student.studentClass);
      print('shared' + sharedPrefs.getString(Constants.studentName));
    });



  }


}
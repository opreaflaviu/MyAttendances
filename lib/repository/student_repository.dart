import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:my_attendances/utils/custom_error.dart';
import 'package:my_attendances/utils/shared_preferences_utils.dart';
import 'package:password/password.dart';
import '../model/student.dart';
import '../utils/constants.dart';

class StudentRepository {
  Future<bool> loginStudent(studentName, studentPassword, studentId) async {
    var response = await http.post(
        Uri.encodeFull(Constants.rootApi + '/users/login'),
        headers: {
          "Accept": "application/json"
        },
        body: {
          Constants.studentId: "$studentId",
        });

    if (response.statusCode == 200) {
      Map responseData = json.decode(response.body);
      if (responseData['result'] == 'false') {
        throw CustomError('User does not exists');
      } else {
        var nameResponse = responseData['result'][Constants.studentName];
        var passwordResponse = responseData['result'][Constants.studentPassword];
        var classResponse = responseData['result'][Constants.studentClass];

        if(_validLogin(studentPassword, passwordResponse, studentName, nameResponse)) {
          Student student = Student(studentId, studentName, classResponse, studentPassword);
          _saveInSharedPrefs(student);
          return true;
        } else {
          throw CustomError('Wrong credentials');
        }
      }
    } else {
      throw CustomError();
    }
  }

  Future<bool> registerStudent(Student student) async {
    var response = await http.post(
        Uri.encodeFull(Constants.rootApi + '/users/add'),
        headers: {
          "Accept": "application/json"
        },
        body: {
          Constants.studentName: "${student.studentName}",
          Constants.studentPassword: "${student.studentPassword}",
          Constants.studentId: "${student.studentId}",
          Constants.studentClass: "${student.studentClass}"
        });

    if (response.statusCode == 200) {
      Map responseData = json.decode(response.body);
      if(responseData['result'] == 'false') {
        throw CustomError('User already exists');
      } else {
        return true;
      }
    } else {
      throw CustomError("Network connection error");
    }
  }

  bool _validLogin(password, passwordResponse, studentName, nameResponse) =>
    Password.verify(password, passwordResponse) && studentName == nameResponse;

  void _saveInSharedPrefs(Student student) async {
    SharedPreferencesUtils sharedPreferencesUtils = SharedPreferencesUtils();
    sharedPreferencesUtils.saveStudent(student);
  }
}

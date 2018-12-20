import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../model/student.dart';
import '../utils/constants.dart';

class StudentRepository {
  Future<Student> loginStudent(studentId, studentPassword) async {
    var response = await http.post(
        Uri.encodeFull(Constants.rootApi + '/users/login'),
        headers: {
          "Accept": "application/json"
        },
        body: {
          Constants.studentId: "$studentId",
          Constants.studentPassword: "$studentPassword"
        });

    if (response.statusCode == 200) {
      Map responseData = json.decode(response.body);
      if (responseData['result'] == 'false') {
        return new Student('', '', 0, '');
      } else {
        var studentClass = int.parse(
            responseData['result'][Constants.studentClass].toString());
        var studentName = responseData['result'][Constants.studentName];
        return new Student(
            studentId, studentName, studentClass, studentPassword);
      }
    } else {
      return new Student('', '', 0, '');
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

      if (responseData['result'] == 'false') {
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }
}

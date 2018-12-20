import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../model/attendance.dart';
import '../model/course.dart';
import '../model/course_attendances.dart';
import '../utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quiver/collection.dart';

class AttendanceRepository {
  Multimap<String, String> _attendanceList;

  AttendanceRepository();

  Future<Multimap<String, String>> getAttendanceForStudent() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var studentId = sharedPreferences.get(Constants.studentId);

    var response = await http.get(
        Uri.encodeFull(Constants.rootApi + '/attendance/$studentId'),
        headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);

      _attendanceList = Multimap();
      List<CourseAttendances> courseAttendancesList = List();
      for (var data in responseData['result']) {
        var courseName = data[Constants.courseName];
        var courseAttendance = CourseAttendances(courseName);
        for (var attendance in data['attendances']) {
          var courseDate = attendance[Constants.courseCreatedAt];
          var courseType = attendance[Constants.courseType];
          var courseNumber = attendance[Constants.courseNumber];
          var course =
              Course(null, courseType, null, null, courseDate, courseNumber);
          courseAttendance.addCourse(course);
        }
        courseAttendancesList.add(courseAttendance);
      }

      for (var el in courseAttendancesList) {
        for (var i = 0; i < el.attendanceList.length; i++) {
          _attendanceList.addValues(
              el.courseName,
              Iterable.castFrom([
                "${el.getCourseType(i)} +: ${el.getCourseNumber(i)}     ${el.getCourseData(i).toString().substring(0, 16)}"
              ]));
        }
      }
      return _attendanceList;
    } else {
      throw Exception("Error");
    }
  }

  Future<bool> saveAttendance(String attendanceString) async {
    var attendanceSplit = attendanceString.split("+");
    String courseName = attendanceSplit.elementAt(0);
    String courseType = attendanceSplit.elementAt(1);
    String courseTeacher = attendanceSplit.elementAt(2);
    String courseTeacherId = attendanceSplit.elementAt(3);
    String courseCreatedAt = attendanceSplit.elementAt(4);
    String courseNumber = attendanceSplit.elementAt(5).toString();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var studentId = sharedPreferences.get(Constants.studentId);
    var course = Course(courseName, courseType, courseTeacher, courseTeacherId,
        courseCreatedAt, courseNumber);
    var attendance = Attendance(
        DateTime.now().toIso8601String(), studentId, attendanceString, course);

    var response = await http.post(
        Uri.encodeFull(Constants.rootApi + '/attendance/add'),
        headers: {"Accept": "application/json"},
        body: {'attendance': json.encode(attendance.toJSON())});

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);

      if (responseData['result'] == 'true') {
        return true;
      } else {
        return true;
      }
    } else {
      throw Exception('Error');
    }
  }
}

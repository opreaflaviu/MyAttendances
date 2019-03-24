import 'package:my_attendances/model/base_student.dart';
import 'package:my_attendances/model/course.dart';
import 'package:my_attendances/model/grade.dart';
import 'package:my_attendances/utils/constants.dart';

class Attendance {
  final String _eventCreatedAt;
  final String _attendanceQR;
  final Course _course;
  final BaseStudent _student;
  final Grade _grade;

  Attendance(
      this._eventCreatedAt, this._attendanceQR, this._course, this._student,
      this._grade);

  Attendance.fromJson(Map attendance):
    this._eventCreatedAt = attendance[Constants.eventCreatedAt],
    this._course = Course.fromJson(attendance[Constants.course]),
    this._student = BaseStudent.fromJSON(attendance[Constants.student]),
    this._grade = Grade.fromJson(attendance[Constants.grade]),
    this._attendanceQR = attendance[Constants.attendanceQR];

  Map<String, dynamic> toJson() {
    var map = Map<String, dynamic>();
    map[Constants.eventCreatedAt] = this._eventCreatedAt;
    map[Constants.student] = this._student.toJson();
    map[Constants.course] = this._course.toJson();
    map[Constants.grade] = this._grade.toJson();
    map[Constants.attendanceQR] = this._attendanceQR;
    return map;
  }

  get eventCreatedAt => _eventCreatedAt;

  get attendanceQR => _attendanceQR;

  Course get course => _course;

  BaseStudent get studentId => _student;
}

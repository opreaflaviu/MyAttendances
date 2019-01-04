import 'package:my_attendances/model/base_student.dart';
import 'package:my_attendances/model/course.dart';
import 'package:my_attendances/utils/constants.dart';

class Attendance {
  final _eventCreatedAt;
  final _attendanceQR;
  final Course _course;
  final BaseStudent _student;

  Attendance(
      this._eventCreatedAt, this._attendanceQR, this._course, this._student);

  Attendance.fromJSON(Map attendance):
    this._eventCreatedAt = attendance[Constants.eventCreatedAt],
    this._course = Course.fromJSON(attendance[Constants.course]),
    this._student = BaseStudent.fromJSON(attendance[Constants.student]),
    this._attendanceQR = attendance[Constants.attendanceQR];

  Map<String, dynamic> toJSON() {
    var map = Map<String, dynamic>();
    map[Constants.eventCreatedAt] = this._eventCreatedAt;
    map[Constants.student] = this._student.toJSON();
    map[Constants.course] = this._course.toJSON();
    map[Constants.attendanceQR] = this._attendanceQR;
    return map;
  }

  get eventCreatedAt => _eventCreatedAt;

  get attendanceQR => _attendanceQR;

  Course get course => _course;

  BaseStudent get studentId => _student;
}

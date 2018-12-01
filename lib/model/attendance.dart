import 'package:my_attendances/model/course.dart';
import 'package:my_attendances/utils/constants.dart';

class Attendance {
  final _eventCreatedAt;
  final _studentId;
  final _attendanceQR;
  final Course _course;

  Attendance(
      this._eventCreatedAt, this._studentId, this._attendanceQR, this._course);


  get eventCreatedAt => _eventCreatedAt;

  Attendance.fromJSON(Map attendance):
    this._eventCreatedAt = attendance[Constants.eventCreatedAt],
    this._studentId = attendance[Constants.studentId],
    this._course = Course.fromJSON(attendance[Constants.course]),
    this._attendanceQR = attendance[Constants.attendanceQR];

  Map<String, dynamic> toJSON() {
    var map = Map<String, dynamic>();
    map[Constants.eventCreatedAt] = this._eventCreatedAt;
    map[Constants.studentId] = this._studentId;
    map[Constants.course] = this._course.toJSON();
    map[Constants.attendanceQR] = this._attendanceQR;
    return map;
  }

  get studentId => _studentId;

  get attendanceQR => _attendanceQR;

  Course get course => _course;
}

import 'package:my_attendances/model/course_attendances.dart';
import 'package:quiver/collection.dart';

abstract class AttendanceBodyView {
  void onLoadAttendancesComplete(List<CourseAttendances> attendanceList);
  void onLoadAttendancesError(Error e);
}
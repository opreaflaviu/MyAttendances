import 'package:quiver/collection.dart';

abstract class AttendanceBodyView {
  void onLoadAttendancesComplete(Multimap<String, String> attendanceList);
  void onLoadAttendancesError();
}
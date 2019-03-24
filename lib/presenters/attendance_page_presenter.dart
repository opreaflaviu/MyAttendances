import 'package:my_attendances/model/course_attendances.dart';

import '../repository/attendance_repository.dart';
import '../views/attendance_body_view.dart';

class AttendancePagePresenter {
  AttendanceBodyView _attendanceBodyView;
  AttendanceRepository _attendanceRepository;

  AttendancePagePresenter(this._attendanceBodyView) {
    _attendanceRepository = AttendanceRepository();
  }

  void getAttendances() {
    _attendanceRepository.getAttendanceForStudent()
        .then((attendanceList) => _attendanceBodyView.onLoadAttendancesComplete(attendanceList))
        .catchError((e) => _attendanceBodyView.onLoadAttendancesError(e));
  }
}
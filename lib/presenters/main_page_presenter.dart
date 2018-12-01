import '../repository/attendance_repository.dart';
import '../views/main_page_view.dart';
import '../model/attendance.dart';

class MainPagePresenter {
  MainPageView _mainPageView;
  AttendanceRepository _attendanceRepository;

  MainPagePresenter(this._mainPageView){
    _attendanceRepository = AttendanceRepository();
  }

  void saveAttendances(var attendance){
    _attendanceRepository.saveAttendance(attendance)
        .then((response) => _mainPageView.onSaveAttendanceComplete())
        .catchError((e) => _mainPageView.onSaveAttendanceError());
  }


}
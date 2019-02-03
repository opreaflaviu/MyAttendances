import 'package:my_attendances/model/base_student.dart';
import 'package:my_attendances/utils/constants.dart';


class Student extends BaseStudent{
  String _studentPassword;

  Student(String _studentId, String _studentName, String _studentClass, this._studentPassword): super(_studentId, _studentName, _studentClass);

  String get studentPassword => this._studentPassword;
  set studentPassword(String studentPassword) {
    this._studentPassword = studentPassword;
  }

  Student.fromJSON(Map map): super(map[Constants.studentId], map[Constants.studentName],map[Constants.studentClass]) {
    this._studentPassword = map[Constants.studentPassword];
  }


  Map<String, dynamic> toJSON() {
    var map = new Map<String, dynamic>();
    map = super.toJSON();
    map[Constants.studentPassword] = this._studentPassword;
    return map;
  }

  @override
  String toString() => super.toString() + " " + _studentPassword;
}
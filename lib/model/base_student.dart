import 'package:my_attendances/utils/constants.dart';

class BaseStudent {
  String _studentId;
  String _studentName;
  String _studentClass;

  BaseStudent(this._studentId, this._studentName, this._studentClass);

  String get studentId => _studentId;
  set studentId(String value) {
    _studentId = value;
  }

  String get studentName => _studentName;
  set studentName(String value) {
    _studentName = value;
  }

  String get studentClass => _studentClass;
  set studentClass(String value) {
    _studentClass = value;
  }

  BaseStudent.fromJSON(Map map){
    this._studentId = map[Constants.studentId];
    this._studentName = map[Constants.studentName];
    this._studentClass = map[Constants.studentClass];
  }

  Map<String, dynamic> toJson() {
    var map = new Map<String, dynamic>();
    map[Constants.studentId] = this._studentId;
    map[Constants.studentName] = this._studentName;
    map[Constants.studentClass] = this._studentClass;
    return map;
  }

  String toString() => this._studentName + " " + this._studentId + " " + this._studentClass.toString();

}
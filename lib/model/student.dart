import 'package:my_attendances/utils/constants.dart';


class Student {
  String _studentId;
  String _studentName;
  int _studentClass;
  String _studentPassword;

  Student(this._studentId, this._studentName, this._studentClass, this._studentPassword);

  String get studentId => this._studentId;
  set studentId(String studentNumber) {
    this._studentId = studentNumber;
  }

  String get studentName => this._studentName;
  set studentName(String studentName) {
    this._studentName = studentName;
  }

  int get studentClass => this._studentClass;
  set studentClass(int studentClass) {
    this._studentClass = studentClass;
  }

  String get studentPassword => this._studentPassword;
  set studentPassword(String studentPassword) {
    this._studentPassword = studentPassword;
  }

  Student.fromMap(Map map){
    this._studentName = map[Constants.studentName];
    this._studentId = map[Constants.studentId];
    this._studentClass = map[Constants.studentClass];
    this._studentPassword = map[Constants.studentPassword];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map[Constants.studentName] = this._studentName;
    map[Constants.studentId] = this._studentId;
    map[Constants.studentClass] = this._studentClass;
    map[Constants.studentPassword] = this._studentPassword;
    return map;
  }

  @override
  String toString() => _studentName + " " + _studentId + " " + _studentClass.toString() + " " + _studentPassword;
}
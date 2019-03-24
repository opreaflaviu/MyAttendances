import 'package:my_attendances/model/grade.dart';
import 'package:my_attendances/utils/constants.dart';

class Course {
  final String _name;
  final String _type;
  final String _class;
  final String _teacher;
  final String _teacherId;
  final String _createdAt;
  final int _number;
  final int _grade;


  Course(this._name, this._type, this._class, this._teacher, this._teacherId,
      this._createdAt, this._number, this._grade);

  Course.fromJson(Map course):
    this._name = course[Constants.courseName],
    this._type = course[Constants.courseType],
    this._class = course[Constants.courseClass],
    this._teacher = course[Constants.courseTeacher],
    this._teacherId = course[Constants.courseTeacherId],
    this._createdAt = course[Constants.courseCreatedAt],
    this._number = int.parse(course[Constants.courseNumber]),
    this._grade = int.parse(course[Constants.grade]);

  Map<String, dynamic> toJson() {
    Map map = Map<String, dynamic>();
    map[Constants.courseName] = this._name;
    map[Constants.courseType] = this._type;
    map[Constants.courseClass] = this._class;
    map[Constants.courseTeacher] = this._teacher;
    map[Constants.courseTeacherId] = this._teacherId;
    map[Constants.courseCreatedAt] = this._createdAt;
    map[Constants.courseNumber] = this._number.toString();
    return map;
  }

  get name => _name;

  get type => _type;

  get teacher => _teacher;

  get teacherId => _teacherId;

  get createdAt => _createdAt;

  get number => _number;

  get courseClass => _class;

  get grade => _grade;

  @override
  String toString() {
    return 'Course{_name: $_name, _type: $_type, , _class: $_class, _teacher: $_teacher, _teacherId: $_teacherId, _createdAt: $_createdAt, _number: $_number}';
  }


}
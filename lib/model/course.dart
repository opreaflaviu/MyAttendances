import 'package:my_attendances/utils/constants.dart';

class Course {
  final _name;
  final _type;
  final _teacher;
  final _teacherId;
  final _createdAt;
  final _number;

  Course(this._name, this._type, this._teacher, this._teacherId, this._createdAt, this._number);


  get name => _name;

  Course.fromJSON(Map course):
    this._name = course[Constants.courseName],
    this._type = course[Constants.courseType],
    this._teacher = course[Constants.courseTeacher],
    this._teacherId = course[Constants.courseTeacherId],
    this._createdAt = course[Constants.courseCreatedAt],
    this._number = course[Constants.courseNumber];

  Map<String, dynamic> toJSON() {
    Map map = Map<String, dynamic>();
    map[Constants.courseName] = this._name;
    map[Constants.courseType] = this._type;
    map[Constants.courseTeacher] = this._teacher;
    map[Constants.courseTeacherId] = this._teacherId;
    map[Constants.courseCreatedAt] = this._createdAt;
    map[Constants.courseNumber] = this._number;
    return map;
  }

  get type => _type;

  get teacher => _teacher;

  get teacherId => _teacherId;

  get createdAt => _createdAt;

  get number => _number;

  @override
  String toString() {
    return 'Course{_name: $_name, _type: $_type, _teacher: $_teacher, _teacherId: $_teacherId, _createdAt: $_createdAt, _number: $_number}';
  }


}
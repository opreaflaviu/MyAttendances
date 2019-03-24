

import 'package:my_attendances/utils/constants.dart';

class Grade {

  int _grade;

  Grade(this._grade);

  int get grade => _grade;

  set grade(int value) {
    _grade = value;
  }

  Grade.fromJson(Map map):
      this._grade = map[Constants.grade];

  Map<String, int> toJson() {
    var map = Map<String, int>();
    map[Constants.grade] = this._grade;

    return map;
  }

}
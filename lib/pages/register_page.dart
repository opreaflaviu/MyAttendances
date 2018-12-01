import 'package:flutter/material.dart';
import 'package:my_attendances/repository/student_repository.dart';
import 'package:my_attendances/utils/colors_constants.dart';
import '../model/student.dart';
import '../utils/shared_preferences_utils.dart';

class RegisterPage extends StatefulWidget {
  @override
  RegisterPageState createState() => new RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  static final TextEditingController _name = new TextEditingController();
  static final TextEditingController _class = new TextEditingController();
  static final TextEditingController _number = new TextEditingController();
  static final TextEditingController _password = new TextEditingController();
  static final TextEditingController _confirmPassword = new TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldState = new GlobalKey<ScaffoldState>();

  String _snackBarText = '';

  void _onChange(String snackBarText){
    setState((){
      _snackBarText = snackBarText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: ColorsConstants.backgroundColorGreen,
      key: _scaffoldState,
      appBar: new AppBar(
          title: new Text("Register", textAlign: TextAlign.center, style: new TextStyle(fontSize: 32.0, color: ColorsConstants.customBlack)),
          centerTitle: true,
          backgroundColor: ColorsConstants.backgroundColorGreen,
          elevation: 1.0,
          automaticallyImplyLeading: false
      ),
      body: new Center(
          child: new Container(
            margin: new EdgeInsets.only(right: 32.0, left: 32.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new TextField(
                    decoration: new InputDecoration(labelText: 'Name', hintText: 'ex: Popescu Ion', contentPadding: new EdgeInsets.only(top: 8.0), labelStyle: new TextStyle(fontSize: 16.0)),
                    style: new TextStyle(fontSize: 20.0, color: Colors.black),
                    controller: _name
                ),

                new TextField(
                    decoration: new InputDecoration(labelText: 'Class',  hintText: 'ex: 111', contentPadding: new EdgeInsets.only(top: 8.0), labelStyle: new TextStyle(fontSize: 16.0)),
                    style: new TextStyle(fontSize: 20.0, color: Colors.black),
                    controller: _class
                ),

                new TextField(
                    decoration: new InputDecoration(labelText: 'Number', contentPadding: new EdgeInsets.only(top: 8.0), labelStyle: new TextStyle(fontSize: 16.0)),
                    style: new TextStyle(fontSize: 20.0, color: Colors.black),
                    controller: _number
                ),

                new TextField(
                    decoration: new InputDecoration(labelText: 'Password', contentPadding: new EdgeInsets.only(top: 16.0), labelStyle: new TextStyle(fontSize: 16.0)),
                    style: new TextStyle(fontSize: 20.0, color: Colors.black),
                    obscureText: true,
                    controller: _password
                ),

                new TextField(
                  decoration: new InputDecoration(labelText: 'Confirm password', contentPadding: new EdgeInsets.only(top: 16.0), labelStyle: new TextStyle(fontSize: 16.0)),
                  obscureText: true,
                  style: new TextStyle(fontSize: 20.0, color: Colors.black),
                  controller: _confirmPassword,
                ),

                new Container(
                  padding: new EdgeInsets.only(top: 16.0),
                ),

                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new RaisedButton(
                      padding: new EdgeInsets.only(left: 32.0, right: 32.0),
                      child: new Text("  Back  ", textScaleFactor: 1.2),
                      onPressed: (() => _onBackClick(context)),
                      splashColor: Colors.white,
                      color: Colors.white,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                    ),

                    new RaisedButton(
                      padding: new EdgeInsets.only(left: 32.0, right: 32.0),
                      child: new Text("Register", textScaleFactor: 1.2),
                      onPressed: _onRegisterClick,
                      splashColor: Colors.white,
                      color: Colors.white,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }

  void _clearTextFields(){
    _name.clear();
    _class.clear();
    _number.clear();
    _password.clear();
    _confirmPassword.clear();
  }

  void _onBackClick(BuildContext context){
    _clearTextFields();
    Navigator.of(context).pop(true);
  }

  void _onRegisterClick(){
    if (_password.text == _confirmPassword.text) {
      if (true){
        Student student = new Student(_number.text, _name.text, int.parse(_class.text), _password.text);
        var s = new StudentRepository().registerStudent(student);
        s.then((response) {
          if (response){
            _saveInSharedPrefs(student);
            Navigator.of(context).pushNamedAndRemoveUntil('main_page', (Route<dynamic> route) =>false);
          } else {
            print(response.toString());
            _onChange('User already exist');
            _showSnackBar();
          }
        });
      } else {
        print("Invalid password");
        _onChange("Invalid password");
        _showSnackBar(); //example: Aa@^1AfaA  Aaa111aAa
      }
    } else {
      print("Different passwords");
      _onChange("Different passwords");
      _showSnackBar();
    }
    _clearTextFields();
  }

  void _showSnackBar(){
    _scaffoldState.currentState.showSnackBar(new SnackBar(
        content: new Text(_snackBarText)
    ));
  }

  void _saveInSharedPrefs(Student student) async {
    SharedPreferencesUtils sharedPreferencesUtils = new SharedPreferencesUtils();
    sharedPreferencesUtils.saveStudent(student);

  }

}

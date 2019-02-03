import 'package:flutter/material.dart';
import 'package:my_attendances/repository/student_repository.dart';
import 'package:my_attendances/utils/colors_constants.dart';
import 'package:password/password.dart';
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
  static final TextEditingController _confirmPassword =
      new TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldState =
      new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var _mediaQuery = MediaQuery.of(context);
    var _widthDP = _mediaQuery.size.width;
    var _heightDP = _mediaQuery.size.height;

    return new Scaffold(
      backgroundColor: ColorsConstants.backgroundColorGreen,
      key: _scaffoldState,
      appBar: new AppBar(
          title: new Text("Register",
              textAlign: TextAlign.center,
              style: new TextStyle(
                  fontSize: 32.0, color: ColorsConstants.customBlack)),
          centerTitle: true,
          backgroundColor: ColorsConstants.backgroundColorGreen,
          elevation: 2.0,
          automaticallyImplyLeading: false),
      body: Center(
          child: SingleChildScrollView(
        child: Container(
            margin: new EdgeInsets.only(right: 32.0, left: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ListTile(
                    contentPadding: EdgeInsets.all(0.0),
                    leading:
                        Icon(Icons.person, color: ColorsConstants.customBlack),
                    title: TextField(
                        cursorColor: ColorsConstants.customBlack,
                        decoration: new InputDecoration(
                            hintText: 'Name',
                            contentPadding: new EdgeInsets.only(bottom: 4.0,
                                top: 8.0),
                            hintStyle: TextStyle(
                                fontSize: 16.0,
                                color: ColorsConstants.customBlack),
                            labelStyle: TextStyle(
                                fontSize: 16.0,
                                color: ColorsConstants.customBlack)),
                        style: TextStyle(
                            fontSize: 16.0, color: ColorsConstants.customBlack),
                        controller: _name)),
                ListTile(
                    contentPadding: EdgeInsets.all(0.0),
                    leading:
                        Icon(Icons.group, color: ColorsConstants.customBlack),
                    title: TextField(
                        cursorColor: ColorsConstants.customBlack,
                        decoration: new InputDecoration(
                            hintText: 'Class',
                            contentPadding: new EdgeInsets.only(bottom: 4.0,
                                top: 8.0),
                            hintStyle: TextStyle(
                                fontSize: 16.0,
                                color: ColorsConstants.customBlack),
                            labelStyle: TextStyle(
                                fontSize: 16.0,
                                color: ColorsConstants.customBlack)),
                        style: TextStyle(
                            fontSize: 16.0, color: ColorsConstants.customBlack),
                        controller: _class)),
                ListTile(
                    contentPadding: EdgeInsets.all(0.0),
                    leading:
                        Icon(Icons.label, color: ColorsConstants.customBlack),
                    title: TextField(
                        cursorColor: ColorsConstants.customBlack,
                        decoration: new InputDecoration(
                            hintText: 'Student id',
                            contentPadding: new EdgeInsets.only(bottom: 4.0,
                                top: 8.0),
                            hintStyle: TextStyle(
                                fontSize: 16.0,
                                color: ColorsConstants.customBlack),
                            labelStyle: TextStyle(
                                fontSize: 16.0,
                                color: ColorsConstants.customBlack)),
                        style: TextStyle(
                            fontSize: 16.0, color: ColorsConstants.customBlack),
                        controller: _number)),
                ListTile(
                    contentPadding: EdgeInsets.all(0.0),
                    leading:
                        Icon(Icons.lock, color: ColorsConstants.customBlack),
                    title: TextField(
                        cursorColor: ColorsConstants.customBlack,
                        decoration: new InputDecoration(
                            hintText: 'Password',
                            contentPadding: new EdgeInsets.only(bottom: 4.0,
                                top: 8.0),
                            hintStyle: TextStyle(
                                fontSize: 16.0,
                                color: ColorsConstants.customBlack),
                            labelStyle: TextStyle(
                                fontSize: 16.0,
                                color: ColorsConstants.customBlack)),
                        style: TextStyle(
                            fontSize: 16.0, color: ColorsConstants.customBlack),
                        obscureText: true,
                        controller: _password)),
                ListTile(
                    contentPadding: EdgeInsets.all(0.0),
                    leading:
                        Icon(Icons.lock, color: ColorsConstants.customBlack),
                    title: TextField(
                      cursorColor: ColorsConstants.customBlack,
                      decoration: new InputDecoration(
                          hintText: 'Confirm password',
                          contentPadding: new EdgeInsets.only(bottom: 4.0,
                              top: 8.0),
                          hintStyle: TextStyle(
                              fontSize: 16.0,
                              color: ColorsConstants.customBlack),
                          labelStyle: TextStyle(
                              fontSize: 16.0,
                              color: ColorsConstants.customBlack)),
                      style: TextStyle(
                          fontSize: 16.0, color: ColorsConstants.customBlack),
                      obscureText: true,
                      controller: _confirmPassword,
                    )),
                new Container(
                  padding: new EdgeInsets.only(top: 16.0),
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      padding: new EdgeInsets.fromLTRB(_widthDP * 0.10,
                          _heightDP * 0.01, _widthDP * 0.10, _heightDP * 0.01),
                      child: new Text("Back",
                          style: TextStyle(
                              color: ColorsConstants.customBlack,
                              fontSize: 16.0)),
                      onPressed: (() => _onBackClick(context)),
                      splashColor: Colors.white,
                      color: Colors.white,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                    ),
                    new RaisedButton(
                      padding: new EdgeInsets.fromLTRB(_widthDP * 0.07,
                          _heightDP * 0.01, _widthDP * 0.07, _heightDP * 0.01),
                      child: new Text("Register",
                          style: TextStyle(
                              color: ColorsConstants.customBlack,
                              fontSize: 16.0)),
                      onPressed: _onRegisterClick,
                      splashColor: Colors.white,
                      color: Colors.white,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                    ),
                  ],
                ),
              ],
            )),
      )),
    );
  }

  void _clearTextFields() {
    _name.clear();
    _class.clear();
    _number.clear();
    _password.clear();
    _confirmPassword.clear();
  }

  void _onBackClick(BuildContext context) {
    _clearTextFields();
    Navigator.of(context).pop(true);
  }

  void _onRegisterClick() {
    if (_password.text == _confirmPassword.text) {
      if (true) {
        var password = Password.hash(
            _password.text,
            PBKDF2(iterationCount: 1000));
        print("hash password: $password");
        Student student = Student(_number.text, _name.text, _class.text, password);
        var studentResponse =  StudentRepository().registerStudent(student);
        studentResponse.then((response) {
          _saveInSharedPrefs(student);
          Navigator.of(context).pushNamedAndRemoveUntil( 'main_page',
                  (Route<dynamic> route) => false);
        }).catchError((error) {
          _showAlertDialog('Error', error.toString());
        });
      } else {
        _showAlertDialog('Error', 'Invalid password');
      }
    } else {
      _showAlertDialog('Error', 'Different passwords');
    }
    _clearTextFields();
  }

  Future<Null> _showAlertDialog(String title, String content) {
    return showDialog<Null>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void _saveInSharedPrefs(Student student) async {
    SharedPreferencesUtils sharedPreferencesUtils =
        new SharedPreferencesUtils();
    sharedPreferencesUtils.saveStudent(student);
  }
}

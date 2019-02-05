import 'package:flutter/material.dart';
import 'package:my_attendances/repository/student_repository.dart';
import 'package:my_attendances/utils/colors_constants.dart';
import 'package:password/password.dart';
import '../model/student.dart';
import '../utils/shared_preferences_utils.dart';

class RegisterPage extends StatefulWidget {
  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  static final TextEditingController _name = TextEditingController();
  static final TextEditingController _class = TextEditingController();
  static final TextEditingController _number = TextEditingController();
  static final TextEditingController _password = TextEditingController();
  static final TextEditingController _confirmPassword = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  bool passwordVisibility = true;
  bool confirmPasswordVisibility = true;

  @override
  Widget build(BuildContext context) {
    var _mediaQuery = MediaQuery.of(context);
    var _widthDP = _mediaQuery.size.width;
    var _heightDP = _mediaQuery.size.height;

    return Scaffold(
      backgroundColor: ColorsConstants.backgroundColorGreen,
      key: _scaffoldState,
      appBar: AppBar(
          title: Text("Register",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 32.0, color: ColorsConstants.customBlack)),
          centerTitle: true,
          backgroundColor: ColorsConstants.backgroundColorGreen,
          elevation: 2.0,
          automaticallyImplyLeading: false),
      body: Center(
          child: SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.only(right: 32.0, left: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ListTile(
                    contentPadding: EdgeInsets.all(0.0),
                    leading:
                        Icon(Icons.person, color: ColorsConstants.customBlack),
                    title: TextField(
                        cursorColor: ColorsConstants.customBlack,
                        decoration: InputDecoration(
                            hintText: 'Name',
                            contentPadding:
                                EdgeInsets.only(bottom: 4.0, top: 8.0),
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
                        decoration: InputDecoration(
                            hintText: 'Class',
                            contentPadding:
                                EdgeInsets.only(bottom: 4.0, top: 8.0),
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
                        decoration: InputDecoration(
                            hintText: 'Student id',
                            contentPadding:
                                EdgeInsets.only(bottom: 4.0, top: 8.0),
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
                        decoration: InputDecoration(
                            hintText: 'Password',
                            contentPadding:
                                EdgeInsets.only(bottom: 4.0, top: 8.0),
                            hintStyle: TextStyle(
                                fontSize: 16.0,
                                color: ColorsConstants.customBlack),
                            labelStyle: TextStyle(
                                fontSize: 16.0,
                                color: ColorsConstants.customBlack),
                            suffix: GestureDetector(
                              child: Icon(this.passwordVisibility
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onTap: () {
                                setState(() {
                                  this.passwordVisibility =
                                      !this.passwordVisibility;
                                });
                              },
                            )),
                        style: TextStyle(
                            fontSize: 16.0, color: ColorsConstants.customBlack),
                        obscureText: this.passwordVisibility,
                        controller: _password)),
                ListTile(
                    contentPadding: EdgeInsets.all(0.0),
                    leading:
                        Icon(Icons.lock, color: ColorsConstants.customBlack),
                    title: TextField(
                      cursorColor: ColorsConstants.customBlack,
                      decoration: InputDecoration(
                          hintText: 'Confirm password',
                          contentPadding:
                              EdgeInsets.only(bottom: 4.0, top: 8.0),
                          hintStyle: TextStyle(
                              fontSize: 16.0,
                              color: ColorsConstants.customBlack),
                          labelStyle: TextStyle(
                              fontSize: 16.0,
                              color: ColorsConstants.customBlack),
                          suffix: GestureDetector(
                            child: Icon(this.confirmPasswordVisibility
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onTap: () {
                              setState(() {
                                this.confirmPasswordVisibility =
                                    !this.confirmPasswordVisibility;
                              });
                            },
                          )),
                      style: TextStyle(
                          fontSize: 16.0, color: ColorsConstants.customBlack),
                      obscureText: this.confirmPasswordVisibility,
                      controller: _confirmPassword,
                    )),
                Container(
                  padding: EdgeInsets.only(top: 16.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      padding: EdgeInsets.fromLTRB(_widthDP * 0.10,
                          _heightDP * 0.01, _widthDP * 0.10, _heightDP * 0.01),
                      child: Text("Back",
                          style: TextStyle(
                              color: ColorsConstants.customBlack,
                              fontSize: 16.0)),
                      onPressed: (() => _onBackClick(context)),
                      splashColor: Colors.white,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                    ),
                    RaisedButton(
                      padding: EdgeInsets.fromLTRB(_widthDP * 0.07,
                          _heightDP * 0.01, _widthDP * 0.07, _heightDP * 0.01),
                      child: Text("Register",
                          style: TextStyle(
                              color: ColorsConstants.customBlack,
                              fontSize: 16.0)),
                      onPressed: _onRegisterClick,
                      splashColor: Colors.white,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
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
        var password =
            Password.hash(_password.text, PBKDF2(iterationCount: 1000));
        print("hash password: $password");
        Student student =
            Student(_number.text, _name.text, _class.text, password);
        var studentResponse = StudentRepository().registerStudent(student);
        studentResponse.then((response) {
          _saveInSharedPrefs(student);
          Navigator.of(context).pushNamedAndRemoveUntil(
              'main_page', (Route<dynamic> route) => false);
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
                child: Text('Ok',
                    style: TextStyle(
                    fontSize: 16.0, color: ColorsConstants.customBlack)
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void _saveInSharedPrefs(Student student) async {
    SharedPreferencesUtils sharedPreferencesUtils = SharedPreferencesUtils();
    sharedPreferencesUtils.saveStudent(student);
  }
}

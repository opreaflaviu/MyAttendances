import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:my_attendances/model/course_attendances.dart';
import 'package:qrcode_reader/qrcode_reader.dart';

import '../presenters/main_page_presenter.dart';
import '../presenters/attendance_page_presenter.dart';
import '../views/main_page_view.dart';
import '../views/attendance_body_view.dart';
import '../utils/colors_constants.dart';
import '../utils/custom_icons.dart';


class MainPage extends StatefulWidget {
  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> implements MainPageView {

  MainPagePresenter _mainPagePresenter;
  DisplayAttendances _attendanceBody;

  MainPageState(){
    _mainPagePresenter = MainPagePresenter(this);
    _attendanceBody = DisplayAttendances();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _scan,
        child: Icon(CustomIcons.qr_code, size: 44.0),
        foregroundColor: ColorsConstants.customBlack,
        backgroundColor: ColorsConstants.backgroundColorGreen,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      body: _attendanceBody,

      appBar: AppBar(
        title: new Text(
            'Attendances',
            textAlign: TextAlign.center, style: new TextStyle(fontSize: 32.0, color: Colors.black87)),
        centerTitle: true,
        backgroundColor: ColorsConstants.backgroundColorGreen,
        elevation: 1.0,
      ),
    );
  }

  _sendAttendance(var attendanceResult){
    _mainPagePresenter.saveAttendances(attendanceResult.toString());
  }

  _scan() async {
    try {
      var attendanceResult = await QRCodeReader()
          .setHandlePermissions(true)
          .setExecuteAfterPermissionGranted(true)
          .scan();
      print(attendanceResult);
      _sendAttendance(attendanceResult);
    } on PlatformException catch(e) {
      print("error ${e.toString()}");
    } on FormatException {
      print('user return without scann');
    }
  }

  Future<Null> _showAlertDialog(String title, String content) {
    return showDialog<Null>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title,
                style: TextStyle(
                  fontSize: 24.0, color: ColorsConstants.customBlack,
                    fontWeight: FontWeight.bold)),
            content: Text(content,
                style: TextStyle(
                    fontSize: 20.0, color: ColorsConstants.customBlack)),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok',
                    style: TextStyle(
                        fontSize: 16.0, color: ColorsConstants.customBlack)),
                onPressed: (){
                  Navigator.of(context).pop();
                }
              ),
            ],
          );
        }
    );
  }


  @override
  void onSaveAttendanceError() {
    _showAlertDialog('Error!', 'Your attendance was not saved\nCheck your internet connection');
  }

  @override
  void onSaveAttendanceComplete() {
    _showAlertDialog('Done', 'Your attendance was succesfully saved\nPull to refresh');
  }
}



class DisplayAttendances extends StatefulWidget{
  @override
  DisplayAttendancesState createState() => DisplayAttendancesState();
}

class DisplayAttendancesState extends State<DisplayAttendances> implements AttendanceBodyView{
  Connectivity _connectivity;
  AttendancePagePresenter _attendancePagePresenter;
  List<CourseAttendances> _attendanceList;
  bool _isFetching = false;


  DisplayAttendancesState(){
    _connectivity = new Connectivity();
    _attendancePagePresenter = AttendancePagePresenter(this);
    _attendanceList = List();
  }


  @override
  Widget build(BuildContext context) {
      if (_isFetching) {
        return SafeArea(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else {
        return SafeArea(
            child: RefreshIndicator(
              child: ListView.builder(
                  itemCount: _attendanceList == null ? 0 : _attendanceList
                      .length,
                  itemBuilder: (context, index) {
                    var attendance = _attendanceList.elementAt(index);
                    return ExpansionTile(
                        title: Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Text(attendance.courseName),
                        ),

                        children: attendance.attendanceList
                            .map((studentAttendance) =>
                            ListTile(
                              title: Padding(
                                padding: EdgeInsets.only(left: 20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text('${studentAttendance.type} ${studentAttendance.number}'),
                                        Padding(padding: EdgeInsets.all(8.0)),
                                        Text('${studentAttendance.teacher}')
                                      ],
                                    ),
                                    Padding(padding: EdgeInsets.all(4.0)),
                                    Row(mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text('${studentAttendance.createdAt}'.substring(0, 16)),
                                        Padding(padding: EdgeInsets.all(8.0)),
                                        Text('Grade: ${studentAttendance
                                            .grade}'),
                                      ],
                                    )
                                  ],
                                )
                              ),
                            ),
                        ).toList()
                    );
                  }
              ),
              onRefresh: _getAttendanceOnRefresh,
            )
        );
      }

    }

  void initState() {
    checkConnectivity();
    super.initState();
  }

  Future<Null> _showAlertDialog(String title, String content) {
    return showDialog<Null>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title,
                style: TextStyle(
                    fontSize: 24.0, color: ColorsConstants.customBlack,
                    fontWeight: FontWeight.bold)),
            content: Text(content,
                style: TextStyle(
                    fontSize: 20.0, color: ColorsConstants.customBlack)),
            actions: <Widget>[
              FlatButton(
                  child: Text('Ok',
                      style: TextStyle(
                          fontSize: 16.0, color: ColorsConstants.customBlack)),
                  onPressed: (){
                    Navigator.of(context).pop();
                  }
              ),
            ],
          );
        }
    );
  }

  _getAttendances() async {
    _attendancePagePresenter.getAttendances();
  }

  Future<bool> _getAttendanceOnRefresh() async {
    await new Future.delayed(Duration(seconds: 1));
    _getAttendances();
    return true;
  }

  checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      setState(() {
        _isFetching = true;
      });
      _getAttendances();
    } else {
      _showAlertDialog('No internet connection', 'Please connect wi-fi or mobile data');
    }
  }


  @override
  void onLoadAttendancesError(Error e) {
    print("error: $e");
  }

  @override
  void onLoadAttendancesComplete(List<CourseAttendances> attendanceList) {
    setState(() {
      _attendanceList = attendanceList;
      _isFetching = false;
    });
  }
}



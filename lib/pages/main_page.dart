import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'package:quiver/collection.dart';

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


  _requestPermission() async {
    Permission permission = Permission.Camera;
    await SimplePermissions.requestPermission(permission);
  }

  _sendAttendance(var attendanceResult){
    _mainPagePresenter.saveAttendances(attendanceResult.toString());
  }

  _scan() async {
    try {
      var attendanceResult = await BarcodeScanner.scan();
      print(attendanceResult);
      _sendAttendance(attendanceResult);
      if (!mounted){
        return;
      }
    } on PlatformException catch(e) {
      print("error ${e.toString()}");
      if (e.code == BarcodeScanner.CameraAccessDenied){
        _requestPermission();
      } else {
        print('error $e');
      }
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
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
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
  Multimap<String, String> _attendanceList;
  bool _isFetching = false;


  DisplayAttendancesState(){
    _connectivity = new Connectivity();
    _attendancePagePresenter = AttendancePagePresenter(this);
    _attendanceList = Multimap();
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
                    var name = _attendanceList.keys.elementAt(index);
                    return ExpansionTile(
                        title: Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Text(name),
                        ),

                        children: _attendanceList[name].toList()
                            .map((val) =>
                            ListTile(
                              title: Padding(
                                padding: EdgeInsets.only(left: 20.0),
                                child: Text(val),
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

  Future<Null> _showAlertDialog() {
    return showDialog<Null>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('No internet connection'),
          content: Text('Please connect wi-fi or mobile data'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
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
      _showAlertDialog();
    }
  }

  @override
  void onLoadAttendancesComplete(Multimap<String, String> attendanceList) {
    setState(() {
      _attendanceList = attendanceList;
      _isFetching = false;
    });
  }

  @override
  void onLoadAttendancesError() {

  }
}



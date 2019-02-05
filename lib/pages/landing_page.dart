import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:my_attendances/utils/colors_constants.dart';

class LandingPage extends StatefulWidget {
  @override
  LandingPageState createState() => new LandingPageState();
}

class LandingPageState extends State<LandingPage> {
  final GlobalKey<ScaffoldState> _scaffoldState =
  new GlobalKey<ScaffoldState>();
  Connectivity _connectivity = new Connectivity();
  StreamSubscription<ConnectivityResult> _connSub;


  @override
  Widget build(BuildContext context) {
    var _mediaQuery = MediaQuery.of(context);
    var _widthDP = _mediaQuery.size.width;
    var _heightDP = _mediaQuery.size.height;

    return new Scaffold(
      backgroundColor: ColorsConstants.backgroundColorGreen,
      resizeToAvoidBottomPadding: false,
      key: _scaffoldState,
      body: new Container(
          padding: new EdgeInsets.symmetric(),
          child: new Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Center(
                    child: Image(
                      image: AssetImage('assets/images/MyAttendancesLogo.png'),
                      width: 300,
                      height: 300,
                    )
                ),
                RaisedButton(
                    padding: new EdgeInsets.fromLTRB(_widthDP * 0.40, _heightDP * 0.02, _widthDP * 0.40, _heightDP * 0.02),
                    child: new Text("Login", style: TextStyle(color: ColorsConstants.customBlack, fontSize: 20.0)),
                    onPressed: (() => Navigator.of(context).pushNamed('login_page')),
                    splashColor: Colors.white,
                    color: Colors.white,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                ),
                Padding(padding: new EdgeInsets.only(top: 20.0)),
                RaisedButton(
                  padding: new EdgeInsets.fromLTRB(_widthDP * 0.37, _heightDP * 0.02, _widthDP * 0.37, _heightDP * 0.02),
                  child: new Text("Register", style: TextStyle(color: ColorsConstants.customBlack, fontSize: 20.0)),
                  onPressed: (() => Navigator.of(context).pushNamed('register_page')),
                  splashColor: Colors.white,
                  color: Colors.white,
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                ),
                Padding(padding: new EdgeInsets.only(top: 50.0)),
              ],
            ),
          )),
    );
  }

  void _showSnackBar(var snackBarText) {
    _scaffoldState.currentState.showSnackBar(new SnackBar(
        content: Padding(
          padding: EdgeInsets.only(left: 32.0, top: 4.0, bottom: 6.0),
          child: Text(
            snackBarText != ConnectivityResult.none ? "Connected" : "No Connection",
            style: TextStyle(fontSize: 16.0),
          ),
        )));
  }

  void initState() {
    super.initState();
    _connSub =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
          _showSnackBar(result);
        });
  }

  @override
  void dispose() {
    _connSub?.cancel();
    super.dispose();
  }
}

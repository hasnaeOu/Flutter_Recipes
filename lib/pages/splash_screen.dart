import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';
import 'package:recipe/utils/my_navigator.dart';
import 'package:recipe/utils/my_theme.dart';
import 'package:recipe/utils/tools.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  PackageInfo _packageInfo = PackageInfo(
    appName: ' ',
    packageName: ' ',
    version: ' ',
    buildNumber: ' ',
  );


  @override
  void initState() {
    super.initState();

    _initPackageInfo();
    Tools.copyDataBase();
    Timer(Duration(seconds: 5), () {
      MyNavigator.goHome(context);
    });
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(
        [/*SystemUiOverlay.top,SystemUiOverlay.bottom*/]);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset(
                          'assets/icon.png',
                          width: 200.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                      _packageInfo == null ? SizedBox() : Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            _packageInfo.appName,
                            style: TextStyle(
                                color: MyColors.vintageReport[2],
                                fontWeight: FontWeight.w900,
                                fontSize: 30.0),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(backgroundColor: MyColors.vintageReport[2],),
                    SizedBox(height: 30.0),
                    Text(
                      'تحميل...',
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16.0, color: MyColors.vintageReport[2],)
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

import 'dart:async';
import 'dart:convert';

import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipes/utils/myNavigator.dart';
import 'package:recipes/utils/tools.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  ScrollController _scrollController = new ScrollController();

  AnimationController _controller;
  Animation<Offset> _offsetAnimation;

  List<String> dbList = ['تحميل البيانات...'];

  String myData = 'Loading';

  @override
  void initState() {
    super.initState();
      
    _initDatabases().then((onValue) {
      for (var item in onValue) {
        setState(() {
          Tools.copyDataBase(item).then((onValue2) {
            print('==============================> Item from : $item');
              setState(() {
                myData = onValue2;
              });
          });
        });
      }
      dbList = onValue;
      dbList.insert(0, 'تحميل البيانات...');
      Timer(Duration(seconds: 5), () => MyNavigator.goToHome(context));
    });

    _controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);

    _offsetAnimation = Tween<Offset>(
      begin: Offset(0.0, 0.0),
      end: const Offset(10.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));
    //Timer(Duration(seconds: 5), () => MyNavigator.goToIntro(context));
  }

  final options = LiveOptions(
    // Show each item through (default 250)
    showItemInterval: Duration(milliseconds: 500),

    // Animation duration (default 250)
    showItemDuration: Duration(seconds: 1),

    // Animations starts at 0.05 visible
    // item fraction in sight (default 0.025)
    visibleFraction: 0.05,

    // Repeat the animation of the appearance
    // when scrolling in the opposite direction (default false)
    // To get the effect as in a showcase for ListView, set true
    //reAnimateOnVisibility: false,
  );

  Widget buildAnimatedItem(
    BuildContext context,
    int index,
    Animation<double> animation,
  ) =>
      // For example wrap with fade transition
      FadeTransition(
        opacity: Tween<double>(
          begin: 0,
          end: 1,
        ).animate(animation),
        // And slide transition
        child: SlideTransition(
          position: Tween<Offset>(
            begin: Offset(10.0, 0),
            end: Offset.zero,
          ).animate(animation),
          // Paste you Widget
          child: Center(child: Text(dbList[index])),
        ),
      );

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
                      Icon(
                        Icons.android,
                        color: Theme.of(context).accentColor,
                        size: 50.0,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          'Recipes',
                          style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 24.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: LiveList.options(
                    options: options,
                    itemBuilder: buildAnimatedItem,
                    scrollDirection: Axis.vertical,
                    itemCount: dbList.length,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    SizedBox(height: 30.0),
                    Text(
                      'تحميل...',
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16.0, color: Theme.of(context).accentColor),
                    ),
                    Text(
                      myData,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 10.0, color: Theme.of(context).accentColor),
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

  Future _initDatabases() async {
    // >> To get paths you need these 2 lines
    final manifestContent =
        await DefaultAssetBundle.of(context).loadString('AssetManifest.json');

    final Map<String, dynamic> manifestMap = jsonDecode(manifestContent);
    // >> To get paths you need these 2 lines

    final dbPaths = manifestMap.keys
        .where((String key) => key.contains('databases/'))
        .where((String key) => key.contains('.db'))
        .toList();
    return dbPaths;
  }
}

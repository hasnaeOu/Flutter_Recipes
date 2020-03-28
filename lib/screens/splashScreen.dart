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

  List<String> dbList = [''];

  @override
  void initState() {
    super.initState();

    _initDatabases().then((onValue) {
      for (var item in onValue) {
        print(':::::::::::::::::::::::::::::::::::::::::> db :$item');
        Tools.copyDataBase(item);
        setState(() {
          dbList.add(item.toString().split('/').last.split('.').first);
        });
      }
      _scrollController.animateTo(
      0.0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
    });

    

    _controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);

    _offsetAnimation = Tween<Offset>(
      begin: Offset(-10.0, 20.0),
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
    reAnimateOnVisibility: false,
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
            begin: Offset(0, -0.1),
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
                          'مطبخي',
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
                  color: Colors.amber,
                  child: LiveList.options(
                    options: options,
                    reverse: true,
                    itemBuilder: buildAnimatedItem,
                    scrollDirection: Axis.vertical,
                    itemCount: dbList.length,
                    controller: _scrollController,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
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
                    )
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
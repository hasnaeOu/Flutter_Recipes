import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:recipes/models/recipeModel.dart';
import 'package:recipes/utils/dataBaseHelper.dart';
import 'package:recipes/utils/myNavigator.dart';
import 'package:sqflite/sqflite.dart';

class CategorieScreen extends StatefulWidget {
  final String title;
  final String path;

  const CategorieScreen({Key key, this.title, this.path = ''})
      : super(key: key);

  @override
  _CategorieScreenState createState() => _CategorieScreenState();
}

class _CategorieScreenState extends State<CategorieScreen> {
  List<Recipe> recipes;
  String myPath, myTitle;

  void updateListView(String p) {
    TemplateDatabaseProvider provider = new TemplateDatabaseProvider(p);
    provider.getAllRecipes().then((onValue) {
      setState(() {
        this.recipes = onValue;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final CategorieScreen args = ModalRoute.of(context).settings.arguments;
    setState(() {
      myPath = args.path;
      myTitle = args.title;
    });
    updateListView(myPath);

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          color: Theme.of(context).primaryColor,
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Center(
                  child: Text(myTitle,
                      style: TextStyle(
                          fontSize: 60.0,
                          fontFamily: GoogleFonts.lalezar().fontFamily,
                          color: Theme.of(context).accentColor)),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  width: double.maxFinite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(
                        Icons.settings,
                        color: Theme.of(context).accentColor,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Expanded(
                  child: this.recipes == null
                      ? Center(
                          child: Text('تحميل...'),
                        )
                      : ListView.builder(
                          itemCount: this.recipes.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.all(15.0),
                              height: 250.0,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).accentColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0))),
                              child: Stack(
                                fit: StackFit.expand,
                                children: <Widget>[
                                  Image.asset(
                                    'assets/images/' +
                                        myPath
                                            .split('/')
                                            .last
                                            .split('.')
                                            .first +
                                        '/' +
                                        this.recipes[index].img +
                                        '.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      width: double.maxFinite,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).accentColor.withOpacity(0.8),
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(25.0),topRight: Radius.circular(25.0),)
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Stack(
                                          alignment: Alignment.bottomCenter,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Container(
                                                    padding:
                                                        EdgeInsets.all(4.0),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white54,
                                                      borderRadius: BorderRadius.all(Radius.circular(100.0))
                                                    ),
                                                    child: this.recipes[index].favorited == true
                                                        ? Icon(Icons.favorite,
                                                            color: Colors.red)
                                                        : Icon(
                                                            Icons
                                                                .favorite,
                                                            color: Colors.black12)),
                                                Expanded(
                                                  child: Text(
                                                    this.recipes[index].name,
                                                    style: TextStyle(
                                                      shadows: [Shadow(color: Theme.of(context).accentColor,blurRadius: 10.0,offset: Offset(1.0, 5.0))],
                                                      color: Theme.of(context).primaryColor,
                                                      fontSize: 18.0,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          this.recipes[index].preparetime.length < 4 ? SizedBox() : Container(
                                            padding: EdgeInsets.all(4.0),
                                            decoration: BoxDecoration(
                                              color: Theme.of(context).accentColor.withOpacity(0.8),
                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(100.0),bottomLeft: Radius.circular(100.0)),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                              SvgPicture.asset('assets/icons/prepare.svg',width: 18.0,color: Colors.black,),
                                                Text(
                                                  this.recipes[index].preparetime,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16.0
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 10.0,),
                                          this.recipes[index].cooktime.length < 4 ? SizedBox() : Container(
                                            padding: EdgeInsets.all(4.0),
                                            decoration: BoxDecoration(
                                              color: Theme.of(context).accentColor.withOpacity(0.8),
                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(100.0),bottomLeft: Radius.circular(100.0)),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                              SvgPicture.asset('assets/icons/time.svg',width: 18.0,color: Colors.black,),
                                                Text(
                                                  this.recipes[index].cooktime,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16.0
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 10.0,),
                                          this.recipes[index].serves.length < 1 ? SizedBox() : Container(
                                            padding: EdgeInsets.all(4.0),
                                            decoration: BoxDecoration(
                                              color: Theme.of(context).accentColor.withOpacity(0.8),
                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(100.0),bottomLeft: Radius.circular(100.0)),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                              SvgPicture.asset('assets/icons/peoples.svg',width: 18.0,color: Colors.black,),
                                              SizedBox(width: 10.0,),
                                                Text(
                                                  this.recipes[index].serves,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16.0
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30.0)),
                                    ),
                                    child: FlatButton(
                                      child: Center(),
                                      onPressed: () {
                                        MyNavigator.goToHome(context);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

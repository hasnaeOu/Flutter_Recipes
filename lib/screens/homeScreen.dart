import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recipes/models/dbModel.dart';
import 'package:recipes/utils/directoryHelper.dart';
import 'package:recipes/utils/myNavigator.dart';

class HomeScreen extends StatefulWidget {
  final String title;

  const HomeScreen({Key key, this.title = 'الرئيسية'}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var listDb = DbModel.titles;
  var images = DbModel.images;
  List<String> listDbFolder;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getApplicationDocumentsDirectory().then((onValue) {
      setState(() {
        listDbFolder = DirectoryHelper.getList(onValue.path);
      });
      print('listDbFolder :::::'+listDbFolder.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
        SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top,SystemUiOverlay.bottom]);
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
                  child: Text(widget.title,
                      style: TextStyle(
                          fontSize: 60.0,
                          fontFamily: GoogleFonts.lalezar().fontFamily,
                          color: Theme.of(context).accentColor)),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
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
                  child: GridView.builder(
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemCount: listDbFolder == null ? 0 : listDbFolder.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          child: Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              Image.asset(
                                images[listDbFolder[index]],
                                fit: BoxFit.cover,
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                    color: Colors.white70,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      listDb[listDbFolder[index]]
                                          .split('/')
                                          .last
                                          .split('.')
                                          .first,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0)),
                                ),
                                child: FlatButton(
                                  child: Center(),
                                  onPressed: () {
                                    MyNavigator.goToCategorie(
                                        context,
                                        listDb[listDbFolder[index]],
                                        listDbFolder[index]);
                                  },
                                ),
                              ),
                            ],
                          ),
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

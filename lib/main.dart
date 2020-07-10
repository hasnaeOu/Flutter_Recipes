import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipes/screens/categorieScreen.dart';
import 'package:recipes/screens/homeScreen.dart';
import 'package:recipes/screens/introScreen.dart';
import 'package:recipes/screens/splashScreen.dart';
import 'package:recipes/utils/myColors.dart';

var routes = <String, WidgetBuilder>{
  "/intro": (BuildContext context) => IntroScreen(),
  "/home": (BuildContext context) => HomeScreen(),
  "/categorie": (BuildContext context) => CategorieScreen(),
};

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  //enum ui = SystemUiOverlay.top;
  //SystemUiOverlay ui = SystemUiOverlay.top;

  @override
  Widget build(BuildContext context) {
    //SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top,SystemUiOverlay.bottom]);
    return MaterialApp(
        //debugShowCheckedModeBanner: false,
        locale: Locale("ar"),
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: MyColors.colors1[0],
          accentColor: MyColors.colors1[2],
          fontFamily: GoogleFonts.cairo().fontFamily,
          textTheme: TextTheme(
            title: TextStyle(color: Color(0XFF3E5E4B)),
          ),
        ),
        home: Directionality(
          textDirection: TextDirection.rtl,
          child: SplashScreen(),
        ),
      routes: routes,
    );
  }
}

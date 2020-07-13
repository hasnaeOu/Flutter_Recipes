import 'package:flutter/material.dart';
import 'package:recipe/pages/about_us.dart';
import 'package:recipe/pages/favorites.dart';
import 'package:recipe/pages/home_screen.dart';
import 'package:recipe/pages/search_screen.dart';
import 'package:recipe/pages/privacy.dart';
import 'package:recipe/pages/recipe_details.dart';
import 'package:recipe/pages/splash_screen.dart';
import 'package:recipe/utils/ads_helper.dart';
import 'package:recipe/utils/my_theme.dart';

var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => Home(),
  "/favorites": (BuildContext context) => Favorites(),
  "/search": (BuildContext context) => Search(),
  "/recipe_details": (BuildContext context) => RecipeDetails2(),
  "/about": (BuildContext context) => About(),
  "/privacy": (BuildContext context) => Privacy(),
};

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AdsHelper.initFacebookAds();
  //AdsHelper.initAdmobAds();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: MyColors.vintageReport[0],
        accentColor: MyColors.vintageReport[1],
        fontFamily: 'Cairo',
        textTheme: TextTheme(
          bodyText2: TextStyle(
              fontSize: 16,
              color: MyColors.vintageReport[2],
              fontWeight: FontWeight.w600),
          headline6: TextStyle(
            fontSize: 18,
            color: MyColors.vintageReport[0],
            fontWeight: FontWeight.w900,
          ),
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

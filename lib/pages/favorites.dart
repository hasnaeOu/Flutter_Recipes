import 'package:facebook_audience_network/ad/ad_banner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:recipe/utils/ads_helper.dart';
import 'package:recipe/utils/my_navigator.dart';
import 'package:recipe/utils/my_theme.dart';
import 'package:recipe/utils/recipes_provider.dart';
import 'package:recipe/utils/strings.dart';
import 'package:url_launcher/url_launcher.dart';

class Favorites extends StatefulWidget {
  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  AdsHelper ads;
  List<String> fav = [];
  PackageInfo packageInfo = PackageInfo(
    appName: ' ',
    packageName: ' ',
    version: ' ',
    buildNumber: ' ',
  );

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      packageInfo = info;
    });
  }

  _launchURLRate() async {
    var url = 'https://play.google.com/store/apps/details?id=' +
        packageInfo.packageName;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURLMore() async {
    var url = 'https://play.google.com/store/apps/developer?id=' +
        Strings.store.split(' ').join(('+'));
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();

    ads = new AdsHelper();
    ads.loadFbInter(AdsHelper.fbInterId_1);

    _initPackageInfo();
  }

  @override
  void dispose() {
    ads.disposeAllAds();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);

    GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

    return ChangeNotifierProvider<RecipesProvider>(
      create: (context) => RecipesProvider(),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          key: _drawerKey,
          endDrawer: buildDrawer(),
          body: Consumer<RecipesProvider>(
            builder: (BuildContext context, model, Widget child) {
              model.getFavRecipesList();
              return Column(
                children: <Widget>[
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: MyColors.vintageReport[2]),
                    child: SafeArea(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: SvgPicture.asset(
                                    'assets/icons/fav.svg',
                                    height: 30.0,
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        Strings.favorites,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                      model.favRecipes.length == 0 ? SizedBox() : Text(
                                        ' (${model.favRecipes.length})',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              IconButton(
                                icon: SvgPicture.asset(
                                  'assets/icons/search.svg',
                                  height: 30.0,
                                  color: MyColors.vintageReport[0],
                                ),
                                onPressed: () {
                                  ads.showInter();
                                  MyNavigator.goSearch(context);
                                },
                              ),
                              IconButton(
                                icon: SvgPicture.asset(
                                  'assets/icons/burger.svg',
                                  height: 20.0,
                                  color: MyColors.vintageReport[0],
                                ),
                                onPressed: () {
                                  _drawerKey.currentState.openEndDrawer();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          color: MyColors.vintageReport[2],
                          child: model.favRecipes.length < 1
                              ? Opacity(
                                  opacity: 0.5,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        SvgPicture.asset(
                                          'assets/icons/empty.svg',
                                          height: 100.0,
                                          color: MyColors.vintageReport[0],
                                        ),
                                        Text(
                                          Strings.favEmpty,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: model.favRecipes.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      margin: EdgeInsets.only(
                                          bottom: 10.0,
                                          right: 10.0,
                                          left: 10.0),
                                      height: 200.0,
                                      decoration: BoxDecoration(
                                          color: MyColors.vintageReport[3],
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15.0))),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0)),
                                        child: Stack(
                                          fit: StackFit.expand,
                                          children: <Widget>[
                                            Hero(
                                              tag: model.favRecipes[index].id,
                                              child: Image.asset(
                                                'assets/images/${model.favRecipes[index].img}.jpg',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                color: Colors.black54,
                                                child: Text(
                                                  model.favRecipes[index].name
                                                      .replaceAll('\n', ''),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                            FlatButton(
                                              onPressed: () {
                                                ads.showFbInter();
                                                MyNavigator.goRecipeDetails(
                                                    context,
                                                    model.favRecipes[index]);
                                              },
                                              child: Container(),
                                            ),
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: IconButton(
                                                iconSize: 50.0,
                                                icon: Container(
                                                  padding: EdgeInsets.all(8.0),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30.0),
                                                      color: MyColors
                                                          .darklight["light"]),
                                                  child: SvgPicture.asset(
                                                    'assets/icons/unlike.svg',
                                                    width: 30.0,
                                                  ),
                                                ),
                                                onPressed: () {
                                                  ads.showFbInter();
                                                  model.updateFav(
                                                      model
                                                          .favRecipes[index].id,
                                                      model.favRecipes[index]
                                                          .favorited);
                                                },
                                                tooltip: 'حذف من المفضلة',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                        ),
                        Container(
                          height: 30.0,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: <Color>[
                                MyColors.vintageReport[2],
                                MyColors.vintageReport[2].withOpacity(0.0)
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        height: 2.0,
                        color: MyColors.vintageReport[0].withOpacity(0.8),
                      ),
                      Container(
                        height: BannerSize.STANDARD.height.toDouble(),
                        decoration: BoxDecoration(
                          color: MyColors.vintageReport[0],
                        ),
                        child: ads.getFbBanner(
                            AdsHelper.fbBannerId_1, BannerSize.STANDARD),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Drawer buildDrawer() {
    return Drawer(
      child: ChangeNotifierProvider<RecipesProvider>(
        create: (context) => RecipesProvider(),
        child: Container(
          color: Theme.of(context).primaryColor,
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  color: Theme.of(context).primaryColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: Image.asset(
                            'assets/icon.png',
                            width: 150.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      packageInfo == null
                          ? SizedBox()
                          : Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: Text(
                                packageInfo.appName,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .apply(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                    ],
                  ),
                ),
                Expanded(
                  child: Consumer<RecipesProvider>(
                    builder: (BuildContext context, model, Widget child) {
                      model.getFavRecipesList();
                      return ListView(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, left: 8.0, bottom: 8.0, right: 8.0),
                            child: FlatButton(
                              padding: EdgeInsets.all(10.0),
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.1),
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(100.0),
                              ),
                              onPressed: () {
                                MyNavigator.goHome(context);
                              },
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  SvgPicture.asset(
                                    'assets/icons/home.svg',
                                    width: 30.0,
                                  ),
                                  SizedBox(
                                    width: 30.0,
                                  ),
                                  Text(
                                    Strings.home,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .apply(
                                            color: MyColors.vintageReport[2]),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, bottom: 8.0, right: 8.0),
                            child: FlatButton(
                              padding: EdgeInsets.all(10.0),
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.1),
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(100.0),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                ads.showFbInter();
                                MyNavigator.goFavorites(context);
                              },
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  SvgPicture.asset(
                                    'assets/icons/fav.svg',
                                    width: 30.0,
                                  ),
                                  SizedBox(
                                    width: 30.0,
                                  ),
                                  Text(
                                    Strings.favorites,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .apply(
                                            color: MyColors.vintageReport[2]),
                                  ),
                                  model.favRecipes.length == 0 ? SizedBox() : Text(
                                    ' (${model.favRecipes.length})',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .apply(
                                            color: MyColors.vintageReport[2]),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, bottom: 8.0, right: 8.0),
                            child: FlatButton(
                              padding: EdgeInsets.all(10.0),
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.1),
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(100.0),
                              ),
                              onPressed: () {
                                _launchURLRate();
                              },
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  SvgPicture.asset(
                                    'assets/icons/rate.svg',
                                    width: 30.0,
                                  ),
                                  SizedBox(
                                    width: 30.0,
                                  ),
                                  Text(
                                    Strings.rate,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .apply(
                                            color: MyColors.vintageReport[2]),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, bottom: 8.0, right: 8.0),
                            child: FlatButton(
                              padding: EdgeInsets.all(10.0),
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.1),
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(100.0),
                              ),
                              onPressed: () {
                                _launchURLMore();
                              },
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  SvgPicture.asset(
                                    'assets/icons/more.svg',
                                    width: 30.0,
                                  ),
                                  SizedBox(
                                    width: 30.0,
                                  ),
                                  Text(
                                    Strings.more,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .apply(
                                            color: MyColors.vintageReport[2]),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, bottom: 8.0, right: 8.0),
                            child: FlatButton(
                              padding: EdgeInsets.all(10.0),
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.1),
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(100.0),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                ads.showFbInter();
                                MyNavigator.goPrivacy(context);
                              },
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  SvgPicture.asset(
                                    'assets/icons/privacy_policy.svg',
                                    width: 30.0,
                                  ),
                                  SizedBox(
                                    width: 30.0,
                                  ),
                                  Text(
                                    Strings.privacy,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .apply(
                                            color: MyColors.vintageReport[2]),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, bottom: 8.0, right: 8.0),
                            child: FlatButton(
                              padding: EdgeInsets.all(10.0),
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.1),
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(100.0),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                ads.showFbInter();
                                MyNavigator.goAbout(context);
                              },
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  SvgPicture.asset(
                                    'assets/icons/about.svg',
                                    width: 30.0,
                                  ),
                                  SizedBox(
                                    width: 30.0,
                                  ),
                                  Text(
                                    Strings.about,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .apply(
                                            color: MyColors.vintageReport[2]),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'الإصدار ' + packageInfo.version,
                    style: TextStyle(
                        color: MyColors.darklight["dark"], fontSize: 16.0),
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

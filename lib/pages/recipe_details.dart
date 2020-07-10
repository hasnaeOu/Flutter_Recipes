import 'package:facebook_audience_network/ad/ad_banner.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipe/models/recipe_medel.dart';
import 'package:recipe/utils/ads_helper.dart';
import 'package:recipe/utils/database_helper.dart';
import 'package:recipe/utils/my_theme.dart';

class RecipeDetails2 extends StatefulWidget {
  @override
  _RecipeDetails2State createState() => _RecipeDetails2State();
}

class _RecipeDetails2State extends State<RecipeDetails2> {
  Recipe recipe;
  AdsHelper ads;
  String fav = '';
  int firstTime = 0;

  void updateFav(int myId, bool operation) {
    TemplateDatabaseProvider provider = new TemplateDatabaseProvider();
    provider.switchFav(myId, operation);
  }

  @override
  void initState() {
    super.initState();

    ads = new AdsHelper();
    ads.loadFbInter(AdsHelper.fbInterId_2);
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
        statusBarIconBrightness: Brightness.light));
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);

    final Map arguments = ModalRoute.of(context).settings.arguments as Map;

    setState(() {
      recipe = arguments["recipe"];
      if (firstTime == 0) {
        fav = recipe.favorited ? 'liked' : 'unliked';
        firstTime++;
      }
    });

    return WillPopScope(
      onWillPop: () {
        ads.showInter();
        Navigator.of(context).pop();
        return new Future.value(false);
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: Column(
            children: <Widget>[
              Expanded(
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      actions: <Widget>[
                        IconButton(
                          icon: FlareActor(
                            "assets/icons/fav.flr",
                            animation: fav,
                            fit: BoxFit.cover,
                          ),
                          onPressed: () {
                            ads.showFbInter();
                            setState(() {
                              if (fav == 'unliked' || fav == 'unlike') {
                                fav = 'like';
                              } else {
                                fav = 'unlike';
                              }
                            });
                            updateFav(recipe.id, recipe.favorited);
                          },
                          tooltip: 'المفضلة',
                        ),
                      ],
                      leading: IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          ads.showFbInter();
                          Navigator.pop(context);
                        },
                        tooltip: 'رجزع',
                      ),
                      expandedHeight: 200.0,
                      floating: true,
                      pinned: true,
                      snap: true,
                      elevation: 50,
                      flexibleSpace: FlexibleSpaceBar(
                          centerTitle: true,
                          titlePadding: EdgeInsets.symmetric(horizontal: 30.0),
                          title: SafeArea(
                            child: Center(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    width: 20.0,
                                  ),
                                  Expanded(
                                    child: Text(
                                      recipe.name.replaceAll('\n', ''),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .apply(color: Colors.white),
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.fade,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          background: Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              Hero(
                                tag: recipe.id,
                                child: Image.asset(
                                  'assets/images/${recipe.img}.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                color: Colors.black45,
                              )
                            ],
                          )),
                    ),
                    new SliverList(
                      delegate: new SliverChildListDelegate(<Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: recipe.summary == null || recipe.summary == '' ? SizedBox() : Stack(
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.only(top: 16.0),
                                padding: const EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                    color: MyColors.vintageReport[2],
                                    border: Border.all(
                                      color: MyColors.vintageReport[0],
                                    ),
                                    borderRadius: BorderRadius.circular(15.0)),
                                child: Stack(
                                  children: <Widget>[
                                    RichText(
                                      text: TextSpan(
                                        text: '\t\t\t\t\t\t\t\t',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: MyColors.vintageReport[0],
                                            fontFamily: 'Cairo'),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: recipe.summary
                                                .replaceAll('<br />', ''),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: MyColors.darklight["dark"],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: SvgPicture.asset(
                                        'assets/icons/idea.svg',
                                        fit: BoxFit.contain,
                                        height: 25.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                  decoration: BoxDecoration(
                                      color: MyColors.vintageReport[2],
                                      border: Border.all(
                                        color: MyColors.vintageReport[0],
                                      ),
                                      borderRadius: BorderRadius.circular(5.0)),
                                  child: Text(
                                    'مقدمة',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: MyColors.vintageReport[0],
                                      fontFamily: 'Cairo',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Divider(
                                  color: MyColors.vintageReport[2],
                                ),
                              ),
                              Column(
                                children: <Widget>[
                                  SvgPicture.asset(
                                    'assets/icons/ingredients.svg',
                                    fit: BoxFit.contain,
                                    height: 80.0,
                                  ),
                                  Text(
                                    'المقادير',
                                    style: Theme.of(context).textTheme.headline6,
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Divider(
                                  color: MyColors.vintageReport[2],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: new EdgeInsets.all(20.0),
                          child: new Text(
                            recipe.ingredients,
                            style: TextStyle(color: MyColors.darklight["dark"]),
                          ),
                        ),
                        ads.getFbNative(AdsHelper.fbNativeId, 200),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Divider(
                                color: MyColors.vintageReport[2],
                              ),
                            ),
                            Column(
                              children: <Widget>[
                                SvgPicture.asset(
                                  'assets/icons/directions.svg',
                                  fit: BoxFit.contain,
                                  height: 80.0,
                                ),
                                Text(
                                  'طريقة التحضير',
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ],
                            ),
                            Expanded(
                              child: Divider(
                                color: MyColors.vintageReport[2],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: new EdgeInsets.all(20.0),
                          child: new Text(
                            recipe.directions,
                            style: TextStyle(color: MyColors.darklight["dark"]),
                          ),
                        ),
                      ]),
                    ),
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
                        AdsHelper.fbBannerId_2, BannerSize.STANDARD),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

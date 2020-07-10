import 'package:facebook_audience_network/ad/ad_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipe/models/recipe_medel.dart';
import 'package:recipe/utils/ads_helper.dart';
import 'package:recipe/utils/database_helper.dart';
import 'package:recipe/utils/my_navigator.dart';
import 'package:recipe/utils/my_theme.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  AdsHelper ads;
  List<Recipe> recipes;
  FocusNode focus;

  void updateListView() {
    TemplateDatabaseProvider provider = new TemplateDatabaseProvider();
    provider.searchRecipes('---').then((onValue) {
      setState(() {
        this.recipes = onValue;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    ads = new AdsHelper();
    ads.loadFbInter(AdsHelper.fbInterId_2);

    focus = new FocusNode();
    focus.requestFocus();
    updateListView();
  }

  @override
  void dispose() {
    ads.disposeAllAds();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: MyColors.vintageReport[2]),
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Text('بحث',style: Theme.of(context).textTheme.headline6),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  margin: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: MyColors.vintageReport[2],
                    borderRadius: BorderRadius.all(
                      Radius.circular(100.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54,
                        blurRadius: 1.0,
                      )
                    ],
                  ),
                  child: TextField(
                    focusNode: focus,
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      hintText: 'كلمات مفتاحية...',
                      border: InputBorder.none,
                    ),
                    onChanged: (keyword){
                      if(keyword != ''){
                        TemplateDatabaseProvider provider =
                        new TemplateDatabaseProvider();
                        provider.searchRecipes(keyword).then((onValue) {
                          setState(() {
                            this.recipes = onValue;
                          });
                        });
                      }else{
                        setState(() {
                          recipes.clear();
                        });
                      }
                    },
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        color: MyColors.vintageReport[2],
                        child: recipes == null || recipes.length == 0
                            ? Opacity(
                              opacity: 0.5,
                              child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SvgPicture.asset(
                                    'assets/icons/nothing_found.svg',
                                    height: 100.0,
                                    color: MyColors.vintageReport[0],
                                  ),
                                  Text('لم يتم العثور على الوصفة',style: Theme.of(context).textTheme.headline6,),
                                ],
                              )),
                            )
                            : ListView.builder(
                          itemCount: recipes.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: EdgeInsets.all(10.0),
                              height: 200.0,
                              decoration: BoxDecoration(
                                  color: MyColors.vintageReport[3],
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(15.0))),
                              child: ClipRRect(
                                borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: <Widget>[
                                    Hero(
                                      tag: recipes[index].id,
                                      child: Image.asset(
                                        'assets/images/${recipes[index].img}.jpg',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        width:
                                        MediaQuery.of(context).size.width,
                                        color: Colors.black54,
                                        child: Text(
                                          recipes[index]
                                              .name
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
                                            context, recipes[index]);
                                      },
                                      child: Container(),
                                    )
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
                          AdsHelper.fbBannerId_2, BannerSize.STANDARD),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

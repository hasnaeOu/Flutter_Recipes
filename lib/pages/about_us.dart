import 'package:facebook_audience_network/ad/ad_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';
import 'package:recipe/utils/ads_helper.dart';
import 'package:recipe/utils/my_theme.dart';
import 'package:recipe/utils/strings.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  AdsHelper ads;
  PackageInfo _packageInfo = PackageInfo(
    appName: ' ',
    packageName: ' ',
    version: ' ',
    buildNumber: ' ',
  );

  @override
  void initState() {
    super.initState();

    ads = new AdsHelper();

    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));

    return Scaffold(
      backgroundColor: MyColors.vintageReport[2],
      body: SafeArea(
        child: Column(
          children: <Widget>[
            ads.getFbBanner(
                AdsHelper.fbBannerId_2, BannerSize.STANDARD),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Text(
                  Strings.about,
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.all(40.0),
                    width: 200.0,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black54,
                          blurRadius: 50.0,
                        )
                      ]
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.asset(
                        'assets/icon.png',
                        width: 200.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            Strings.aboutText,
                            style: TextStyle(
                                fontSize: 15.0, color: MyColors.vintageReport[0]),
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          )),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                'إصدار : ' + _packageInfo.version,
                style: TextStyle(
                    fontSize: 15.0, color: MyColors.darklight["dark"]),
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

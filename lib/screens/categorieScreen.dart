import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CategorieScreen extends StatefulWidget {
  final String title;

  const CategorieScreen({Key key, this.title = 'عنوان -- الصنف'}) : super(key: key);

  @override
  _CategorieScreenState createState() => _CategorieScreenState();
}

class _CategorieScreenState extends State<CategorieScreen> {
  double wdth = 50.0;

  @override
  Widget build(BuildContext context) {
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
                  child: Text(widget.title,
                      style: TextStyle(
                          fontSize: 40.0,
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.bold)),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  width: double.maxFinite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      AnimatedContainer(
                        width: wdth,
                        height: 50.0,
                        duration: Duration(milliseconds: 500),
                        decoration: BoxDecoration(
                            color: Color(0XFF3A8871),
                            borderRadius: BorderRadius.all(
                              Radius.circular(100.0),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: TextField(
                            textInputAction: TextInputAction.search,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'بحث',
                              suffixIcon: InkWell(child: Icon(Icons.search)),
                            ),
                            onTap: () {
                              setState(() {
                                wdth = 250.0;
                              });
                            },
                            onSubmitted: (value) {
                              setState(() {
                                wdth = 50.0;
                              });
                            },
                          ),
                        ),
                      ),
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
                  child: ListView.builder(
                    itemCount: 15,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.all(15.0),
                        height: 250.0,
                        decoration: BoxDecoration(
                            color: Theme.of(context).accentColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0))),
                        child:
                            Center(child: Text('Item : ' + index.toString())),
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

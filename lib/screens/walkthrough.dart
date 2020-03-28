import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Walkthrough extends StatefulWidget {
  final title;
  final content;
  final imageIcon;

  Walkthrough(
       {this.title,
        this.content,
        this.imageIcon,});

  @override
  WalkthroughState createState() {
    return WalkthroughState();
  }
}
bool i = false;
class WalkthroughState extends State<Walkthrough>
    with SingleTickerProviderStateMixin {
  Animation animationPos;
  Animation animationOpacity;
  AnimationController animationController;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 1500));
    animationPos = Tween(begin: -50.0, end: 0.0).animate(CurvedAnimation(parent: animationController, curve: Curves.easeOutCubic));
    animationOpacity = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: animationController, curve: Curves.linear));

    animationPos.addListener(() => setState(() {}));

    animationController.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 80.0),
        color: Theme.of(context).primaryColor,
        child: AnimatedContainer(
          width: double.maxFinite,
          duration: Duration(milliseconds: 500),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Text(
                widget.title,
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).accentColor),
              ),
              Opacity(
                opacity: animationOpacity.value,
                child: new Transform(
                  transform:
                  new Matrix4.translationValues( 0.0, animationPos.value, 0.0),
                  child: new Text(widget.content,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 15.0,
                          color: Theme.of(context).accentColor)),
                ),
              ),new Icon(
                widget.imageIcon,
                size: 100.0,
                color: Theme.of(context).accentColor,
              ),
            ],
          ),
        ),
      )
    );
  }
}

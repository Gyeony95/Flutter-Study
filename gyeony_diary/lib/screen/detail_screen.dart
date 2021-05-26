import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gyeony_diary/widget/shadowed_card.dart';
import 'dart:ui' as ui;

class DetailScreen extends StatefulWidget {
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  @override
  Widget build(BuildContext context) {
    var viewWidth = MediaQuery.of(context).size.width;
    var viewHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Container(
          child:
          StaggeredGridView.countBuilder(
            crossAxisCount: 4,
            itemCount: 30,
            itemBuilder: (BuildContext context, int index) => new Container(
                color: Colors.green,
                child: new Center(
                  child: new CircleAvatar(
                    backgroundColor: Colors.white,
                    child: new Text('$index'),
                  ),
                )),
            staggeredTileBuilder: (int index) =>
            new StaggeredTile.count(2, index.isEven ? 2 : 1),
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
          )
          // Stack(
          //   children: [
          //
          //     backdropFilter(context,ShadowedCard(
          //       child: Image.asset(
          //         'assets/images/default_image2.jpeg',
          //         height: viewHeight,
          //         //width: MediaQuery.of(context).size.width,ß
          //         //fit: BoxFit.none,
          //       ),
          //     ),)
          //   ],
          // ),
        ),
      ),
    );
  }
}

Widget backdropFilter(BuildContext context, Widget child) {
  return Stack(
    fit: StackFit.expand,
    children: <Widget>[
      child,
      BackdropFilter(
        filter: ui.ImageFilter.blur(
          sigmaX: 8.0,
          sigmaY: 8.0,
        ),
        child: Container(
          color: Colors.transparent,
        ),
      )
    ],
  );
}

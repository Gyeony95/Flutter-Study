import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NotFoundScreen extends StatelessWidget {
  final unknownRouteName;

  NotFoundScreen(this.unknownRouteName);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      centerTitle: true,
      leading: Center(
        child: InkResponse(
          child: SvgPicture.asset('assets/images/ic_left_arrow_b.svg'),
          onTap: () => Navigator.pop(context),
        ),
      ),
      title: Text('존재하지 않은 페이지'),
    ),
    body: Padding(
      padding: const EdgeInsets.only(
        left: 32.0,
        right: 32.0,
        bottom: 64.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.not_interested,
            size: 128,
            color: Colors.red,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 32.0),
            child: Text(
              '$unknownRouteName\n페이지가 존재하지 않습니다.',
              style: TextStyle(
                fontSize: 32,
                color: Colors.red,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ),
  );
}

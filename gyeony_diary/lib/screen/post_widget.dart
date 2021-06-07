import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gyeony_diary/model/post_model.dart';

class PostItem extends StatelessWidget {
  final PostModel model;
  final Function openPressed;
  const PostItem({this.model, this.openPressed});

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: () => Get.toNamed('/griditem'),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              offset: Offset(0.0, 10.0),
              blurRadius: 25.0,
            )
          ],
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
        padding: EdgeInsets.all(10),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(model.time),
                Spacer(),
                IconButton(
                  onPressed: (){},
                  icon: Icon(
                    Icons.list,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10.0),
                topLeft: Radius.circular(10.0),
                bottomRight:Radius.circular(10.0),
                bottomLeft:Radius.circular(10.0),
              ),
              child:
              !model.isOpened ?
              Image.asset(
                model.imageUrl,
                height: 100,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.none,
              ) : Image.asset(
                model.imageUrl,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              model.content,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5,
            ),
            InkResponse(
              onTap: (){
                debugPrint('ghghgh '+model.isOpened.toString());
                openPressed.call();
              },
              child: Text(
                '더보기',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}


class PostOpenedItem extends StatelessWidget {
  final PostModel model;
  final VoidCallback closedPressed;
  const PostOpenedItem({this.model, this.closedPressed});

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: () => Get.toNamed('/griditem'),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              offset: Offset(0.0, 10.0),
              blurRadius: 25.0,
            )
          ],
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
        padding: EdgeInsets.all(10),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(model.time),
                Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.list,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10.0),
                topLeft: Radius.circular(10.0),
                bottomRight:Radius.circular(10.0),
                bottomLeft:Radius.circular(10.0),
              ),
              child: Image.asset(
                model.imageUrl,
                //height: 100,
                width: MediaQuery.of(context).size.width,
                //fit: BoxFit.none,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              model.content,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5,
            ),
            InkResponse(
              onTap: ()=> closedPressed,
              child: Text(
                '접기',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}

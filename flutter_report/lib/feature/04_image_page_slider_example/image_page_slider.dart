import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImagePageSlider extends StatefulWidget {

  const ImagePageSlider({Key? key}) : super(key: key);

  @override
  _ImagePageSliderState createState() => _ImagePageSliderState();
}

class _ImagePageSliderState extends State<ImagePageSlider> {

  List<String >imageUrlList = [
    'http://t1.daumcdn.net/friends/prod/editor/dc8b3d02-a15a-4afa-a88b-989cf2a50476.jpg',
    'http://t1.daumcdn.net/friends/prod/editor/dc8b3d02-a15a-4afa-a88b-989cf2a50476.jpg',
    'http://t1.daumcdn.net/friends/prod/editor/dc8b3d02-a15a-4afa-a88b-989cf2a50476.jpg',
    'http://t1.daumcdn.net/friends/prod/editor/dc8b3d02-a15a-4afa-a88b-989cf2a50476.jpg',
  ];


  /// 여러개인 경우 페이지뷰가 생성되고, 그때 사용되는 페이지 컨트롤러
  final PageController _pageController = PageController();

  /// 현재 페이지
  int _page = 0;

  /// 페이지 변경시 콜백
  void _onPageChange(int pos) {
    setState(() {
      _page = pos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      key: const ValueKey('ModalPopup'),
      backgroundColor: Colors.black.withOpacity(0.6),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            // 이미지 및 자세히 보기
            AspectRatio(
              aspectRatio: 0.7,
              child: imageUrlList.length == 1
                  ? _getCacheImage(imageUrlList.first)
                  : _pageView,
            ),
            SizedBox(height: 16.w,),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget get _appBar{
    return AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      title: Container(
        alignment: Alignment.center,
        child: RichText(
          text: TextSpan(
            text: '${_page+1}',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
            ),
            children: [
              TextSpan(
                text: ' / ${imageUrlList.length}',
                style: const TextStyle(color: Color(0xff565656)),
              )
            ],
          ),
        ),
      ),
      actions: [
        InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
              margin: EdgeInsets.only(right: 21.w),
              child: Icon(Icons.clear, size: 21.w, color: Colors.white, )),),
      ],
    );
  }

  /// 데이터가 2개 이상인 경우 생성되는 페이지뷰
  Widget get _pageView => LayoutBuilder(
    builder: (_, box) {
      return SizedBox(
        child: PageView(
          physics: const ClampingScrollPhysics(),
          controller: _pageController,
          onPageChanged: _onPageChange,
          children: imageUrlList.map((e) => _getCacheImage(e)).toList(),
        ),
      );
    },
  );


  /// 개별 이미지
  Widget _getCacheImage(String url) => Image.network(url, fit: BoxFit.contain, width: 360.w,);
}

part of 'graph_page.dart';

/// [FlDotPainter]를 상속받아서 디자인 요구사항에 맞게 마지막 데이터에 해당 월의
/// 실천율을 라운드 박스 안에 넣아서 표시한다.
class _DotPainter extends FlDotPainter {
  _DotPainter({
    required this.radius,
    required this.color,
    required this.value,
  }) {
    tp = TextPainter(
      text: TextSpan(
          text: '$value%',
          style: TextStyle(
            fontSize: 13.sp,
            color: const Color(0xFF333333),
          )),
      textDirection: TextDirection.ltr,
    )..layout();
    final textSize = tp.size;
    rectSize = Size(
      textSize.width + (horizontalPadding * 2),
      textSize.height + (verticalPadding * 2),
    );
  }

  /// 데이터 지점에 표시되는 원의 반지름
  final double radius;

  /// 색상
  final Color color;

  /// 해당 월의 실천률
  final int value;

  /// 사각형의 수평 패딩값
  final double horizontalPadding = 5.w;

  /// 사각형의 수직 패딩값
  final double verticalPadding = 2.w;

  /// 그려질 사각형과 데이터지점과의 패딩
  final double rectMargin = 8.w;

  /// 실천률을 그리기 위한 페인터
  late final TextPainter tp;

  /// 그려질 사각형의 크기
  late final Size rectSize;

  @override
  void draw(Canvas canvas, FlSpot spot, Offset offsetInCanvas) {
    final shadowPath = Path();
    shadowPath.addOval(Rect.fromCircle(
      center: Offset(
        offsetInCanvas.dx,
        offsetInCanvas.dy + 1,
      ),
      radius: radius + 0.5,
    ));
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.2)
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1.5);
    canvas.drawPath(shadowPath, shadowPaint);

    canvas.drawCircle(
        offsetInCanvas,
        radius,
        Paint()
          ..color = color
          ..style = PaintingStyle.fill);

    final rRect = RRect.fromLTRBR(
      offsetInCanvas.dx - rectSize.width,
      offsetInCanvas.dy - rectMargin - rectSize.height,
      offsetInCanvas.dx,
      offsetInCanvas.dy - rectMargin,
      Radius.circular(4.w),
    );

    // draw rect fill
    canvas.drawRRect(
      rRect,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill,
    );

    // draw rect stroke
    canvas.drawRRect(
      rRect,
      Paint()
        ..color = color
        ..strokeWidth = 1.5
        ..style = PaintingStyle.stroke,
    );

    // draw value
    tp.paint(
      canvas,
      Offset(
        // %가 조금 길어서 보정값으로 1 더해줌
        offsetInCanvas.dx - tp.width - horizontalPadding + 1,
        offsetInCanvas.dy - tp.height - rectMargin - verticalPadding,
      ),
    );
  }

  @override
  Size getSize(FlSpot spot) {
    return Size(
      rectSize.width,
      rectSize.height + rectMargin + (radius * 2),
    );
  }

  @override
  List<Object?> get props => [
    radius,
    color,
    value,
  ];
}

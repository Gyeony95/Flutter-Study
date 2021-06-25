
import 'dart:developer';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

class Sky extends CustomPainter {
  final ui.Image image;
  final ui.Rect stateRect;
  const Sky(this.image, this.stateRect);

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    // final Rect rect  = Rect.fromPoints(Offset(410,1249), Offset(712,1335));
    // final Rect rect  = Rect.fromPoints(Offset(535,1623), Offset(798,1705));

    const RadialGradient gradient = RadialGradient(
      center: Alignment(0.7, -0.6),
      radius: 0.2,
      colors: <Color>[Color(0xFF000000), Color(0xFF000000)],
      stops: <double>[0.4, 1.0],
    );


    // ui.Offset center = size.center(Offset.zero);
    //
    // final imageOffset = center
    //     .scale(1 / 2, 1 / 2) // we have to reverse the scaling done, using 1 / c
    //     .translate(-image.width / 2, -image.height / 2) +
    //     Offset(2, 2).scale(1 / 2, 1 / 2); // here we use the x, y
    //
    //

    canvas.drawImage(image, Offset.zero, Paint());
    // loadUiImage('assets/test.jpeg').then((value) => canvas.drawImage(value, Offset.zero, Paint()));
    // canvas.drawRect(
    //   rect,
    //   Paint()..shader = gradient.createShader(rect),
    // );
    canvas.drawRect(
      stateRect,
      Paint()..shader = gradient.createShader(stateRect),
    );
  }


  //
  // Future<UI.Image> loadUiImage(String imageAssetPath) async {
  //   final ByteData data = await rootBundle.load(imageAssetPath);
  //   final Completer<UI.Image> completer = Completer();
  //   UI.decodeImageFromList(Uint8List.view(data.buffer), (UI.Image img) {
  //     return completer.complete(img);
  //   });
  //   return completer.future;
  // }
  // getImageFromAsset(){
  //   rootBundle.load("images/1.jpg").then( (bd) {
  //     Uint8List lst = new Uint8List.view(bd.buffer);
  //     ui.instantiateImageCodec(lst).then( (codec) {
  //       codec.getNextFrame().then(
  //               (frameInfo) {
  //             imagetoDraw = frameInfo.image;
  //             print ("bkImage instantiated: $imagetoDraw");
  //           }
  //       );
  //     });
  //   });
  // }

  // @override
  // SemanticsBuilderCallback get semanticsBuilder {
  //   return (Size size) {
  //     // Annotate a rectangle containing the picture of the sun
  //     // with the label "Sun". When text to speech feature is enabled on the
  //     // device, a user will be able to locate the sun on this picture by
  //     // touch.
  //     Rect rect = Offset.zero & size;
  //     final double width = size.shortestSide * 0.4;
  //     rect = const Alignment(0.8, -0.9).inscribe(Size(width, width), rect);
  //     return <CustomPainterSemantics>[
  //       CustomPainterSemantics(
  //         rect: rect,
  //         properties: const SemanticsProperties(
  //           label: 'Sun',
  //           textDirection: TextDirection.ltr,
  //         ),
  //       ),
  //     ];
  //   };
  // }

  @override
  bool shouldRepaint(Sky oldDelegate) => false;
  @override
  bool shouldRebuildSemantics(Sky oldDelegate) => false;
}
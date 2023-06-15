import 'package:flutter/material.dart';

class StartMarkerPainter extends CustomPainter {
  final String description;
  final int minutes;

  StartMarkerPainter({required this.description, required this.minutes});
  @override
  void paint(Canvas canvas, Size size) {
//Purple pencil
    final purplePaint = Paint()..color = Colors.deepPurple;
//White pencil
    final whitePaint = Paint()..color = Colors.white;

    const double circlePurpleRadius = 20;
    const double circleWhiteRadius = 7;

    //Black circle
    canvas.drawCircle(
        Offset(circlePurpleRadius, size.height - circlePurpleRadius),
        circlePurpleRadius,
        purplePaint);
    //White circle
    canvas.drawCircle(
        Offset(circlePurpleRadius, size.height - circlePurpleRadius),
        circleWhiteRadius,
        whitePaint);

    //White box
    final path = Path();
    path.moveTo(40, 20);
    path.lineTo(size.width - 10, 20);
    path.lineTo(size.width - 10, 100);
    path.lineTo(40, 100);

    //box shadow
    canvas.drawShadow(path, Colors.black, 10, false);

    canvas.drawPath(path, whitePaint);

    //Purple box

    const purpleBox = Rect.fromLTWH(40, 20, 70, 80);
    canvas.drawRect(purpleBox, purplePaint);

    //Text

    final textSpan = TextSpan(
      style: const TextStyle(
          color: Colors.white, fontSize: 30, fontWeight: FontWeight.w400),
      text: '$minutes',
    );

    //Minutes

    final minutesPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center)
      ..layout(minWidth: 70, maxWidth: 70);

    minutesPainter.paint(canvas, const Offset(40, 35));

//Text min word

    const textSpanMin = TextSpan(
      style: TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.w300),
      text: 'Min',
    );

    //Minutes min word

    final minutesPainterMin = TextPainter(
        text: textSpanMin,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center)
      ..layout(minWidth: 70, maxWidth: 70);

    minutesPainterMin.paint(canvas, const Offset(40, 68));

    //Description

    final textSpanDescription = TextSpan(
      style: const TextStyle(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.w400),
      text: description,
    );

    final descriptionPainter = TextPainter(
        maxLines: 2,
        ellipsis: '...',
        text: textSpanDescription,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.left)
      ..layout(minWidth: size.width - 135, maxWidth: size.width - 135);

    final double offsetY = (description.length > 20) ? 35 : 48;

    descriptionPainter.paint(canvas, Offset(120, offsetY));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) => false;
}

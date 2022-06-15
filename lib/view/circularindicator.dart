import 'package:flutter/material.dart';
import 'dart:math';

class _MultipleColorCirclePainter extends CustomPainter {
  final Map<Color, int> colorOccurrences;
  final double height;
  @override
  _MultipleColorCirclePainter(
      {required this.colorOccurrences, required this.height});
  double pie = pi;

  @override
  void paint(Canvas canvas, Size size) {
    double strokeWidth = 12;
    Rect myRect =
        Rect.fromCircle(center: Offset(height / 2, height / 2), radius: height);

    double radianStart = 0;
    double radianLength = 0;
    int allOccurrences = 0;
    //set denominator
    colorOccurrences.forEach((color, occurrence) {
      allOccurrences += occurrence;
    });
    colorOccurrences.forEach((color, occurrence) {
      double percent = occurrence / allOccurrences;
      radianLength = 2 * percent * pi;
      canvas.drawArc(
          myRect,
          radianStart,
          radianLength,
          false,
          Paint()
            ..color = color
            ..strokeWidth = strokeWidth
            ..style = PaintingStyle.stroke);
      radianStart += radianLength;
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class circlegraph extends StatelessWidget {
  final Map<Color, int> colorOccurrences;
  final double height;
  final String totaltime;

  const circlegraph(
      {Key? key,
      required this.colorOccurrences,
      required this.height,
      required this.totaltime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: height,
      child: CustomPaint(
        child: Center(
          child: Column(
            children: [
              Text(
                "Total",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
              ),
              Text(
                totaltime,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 27),
              )
            ],
          ),
        ),
        painter: _MultipleColorCirclePainter(
            colorOccurrences: colorOccurrences, height: height),
      ),
    );
  }
}

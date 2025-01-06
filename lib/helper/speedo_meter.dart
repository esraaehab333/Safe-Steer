/*import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kdgaugeview/kdgaugeview.dart';
import 'package:safe_steer/constants/colors.dart';

class SpeedoMeter extends StatefulWidget {
  const SpeedoMeter({super.key , required this.value});
  final  value;

  @override
  State<SpeedoMeter> createState() => _SpeedoMeterState();
}

class _SpeedoMeterState extends State<SpeedoMeter> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 100,
      child:Text(widget.value),
    );
  }
}*/
/*
* KdGaugeView(
        minSpeed: 0,
        maxSpeed: 240,
        speed: double.parse(widget.value),
        minMaxTextStyle: GoogleFonts.genos(
          fontSize: 9.sp,
          color: MyWhite1,
          fontWeight: FontWeight.w400,
        ),
        speedTextStyle: GoogleFonts.genos(
          fontSize: 22.sp,
          color: MyWhite1,
          fontWeight: FontWeight.w800,
        ),
        unitOfMeasurementTextStyle: GoogleFonts.genos(
          fontSize: 12.sp,
          color: MyBlueGradiant5,
          fontWeight: FontWeight.w600,
        ),
        gaugeWidth: 1,
        unitOfMeasurement: "kmh",
        innerCirclePadding: 12,
        activeGaugeColor: MyBlueGradiant2,
        divisionCircleColors: Colors.white,
        subDivisionCircleColors: MyBlueGradiant5,
      ),*/
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:safe_steer/constants/colors.dart';

class SpeedMeter extends StatefulWidget {
  const SpeedMeter({super.key, required this.speed});
  final String speed;

  @override
  State<SpeedMeter> createState() => _SpeedMeterState();
}

class _SpeedMeterState extends State<SpeedMeter>
    with SingleTickerProviderStateMixin {
  late Animation<double> anim;
  late AnimationController ctrl;

  @override
  void initState() {
    super.initState();
    ctrl = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    anim = Tween<double>(begin: 0, end: 72).animate(ctrl);
    ctrl.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Container(
            width: 500,
            height: 500,
            child: AnimatedBuilder(
              builder: (context, child) {
                return CustomPaint(
                  painter: MeterPainter(widget.speed),
                );
              },
              animation: ctrl,
            ),
          ),
        ),
    );
  }
}

class MeterPainter extends CustomPainter {
  final String percent;

  MeterPainter(this.percent);

  @override
  void paint(Canvas canvas, Size size) {
    final w = 150;
    final h = 150;
    final centerX = w / 3;
    final centerY = h / 3;

    final center = Offset(centerX, centerY);
    final rect =
        Rect.fromCenter(center: center, width: w * 0.7, height: h * 0.7);
    final largeRect =
        Rect.fromCenter(center: center, width: w * 0.75, height: h * 0.75);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = MyWhite;

    final thickPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..color = MyGray;
    final startAngle = angleToRadian(135);
    final sweepAngle = angleToRadian(270);

    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
    canvas.drawArc(largeRect, startAngle, sweepAngle, false, thickPaint);

    final pointedSweeepAngle = angleToRadian(270 * double.parse(percent) / 100);

    canvas.drawArc(
      largeRect,
      startAngle,
      pointedSweeepAngle,
      false,
      thickPaint..color = MyGradiantCancelCarButton2,
    );

    final radius = w / 2;

    for (num angle = 135; angle <= 405; angle += 4.5) {
      final start = angleToOffset(center, angle, radius * 0.7);
      final end = angleToOffset(center, angle, radius * 0.65);
      canvas.drawLine(start, end, paint);
    }

    final highlights = List.generate(11, (index) => 135 + (27 * index));
    for (int i = 0; i < highlights.length; i++) {
      var angle = highlights[i];
      final start = angleToOffset(center, angle, radius * 0.7);
      final end = angleToOffset(center, angle, radius * 0.575);
      canvas.drawLine(start, end, paint);

      final tp = TextPainter(
          text: TextSpan(text: "${i * 10}",style: TextStyle(fontSize: 10)), textDirection: TextDirection.ltr);
      tp.layout();
      final textOffset = angleToOffset(center, angle, radius * 0.5);
      final centered =
          Offset(textOffset.dx - tp.width / 2, textOffset.dy - tp.height / 2);
      tp.paint(canvas, centered);
    }

    final tp = TextPainter(
        text: TextSpan(
            text: "${percent}",
            style: TextStyle(fontSize: 30),
            children: [
              TextSpan(
                text: "\nkm/h",
                style: TextStyle(fontSize: 10),
              )
            ]),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    tp.layout();
    final centered =
        Offset(center.dx - tp.width / 2, center.dy - tp.height / 2);
    tp.paint(canvas, centered);
  }

  Offset angleToOffset(Offset center, num angle, double distance) {
    final radian = angleToRadian(angle);
    final x = center.dx + distance * cos(radian);
    final y = center.dx + distance * sin(radian);
    return Offset(x, y);
  }

  double angleToRadian(num angle) {
    return angle * pi / 180;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

import 'package:flutter/material.dart';

class StepProgressBar extends StatelessWidget {
  final int totalSteps;
  final int currentStep;

  const StepProgressBar(
      {super.key, required this.totalSteps, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ProgressBarPainter(
        totalSteps: totalSteps,
        currentStep: currentStep,
      ),
      child: const SizedBox(
        width: double.infinity,
        height: 25,
      ),
    );
  }
}

class ProgressBarPainter extends CustomPainter {
  final int totalSteps;
  final int currentStep;

  ProgressBarPainter({required this.totalSteps, required this.currentStep});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint backgroundPaint = Paint()
      ..color = Colors.grey[300]!
      ..style = PaintingStyle.fill;

    final Paint progressPaint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.greenAccent.withOpacity(0.5), Colors.teal],
        stops: const [0.0, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final Paint circlePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final double progress = (currentStep / totalSteps) * size.width;

    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, size.width, size.height),
          const Radius.circular(20)),
      backgroundPaint,
    );

    if (currentStep > 0) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, progress, size.height),
            const Radius.circular(23)),
        progressPaint,
      );
    }

    final double circleRadius = size.height / 2.2;
    final double circleXPosition =
        (currentStep == 0) ? circleRadius : progress - circleRadius - 2;
    final double circleYPosition = size.height / 2;

    canvas.drawCircle(
        Offset(circleXPosition, circleYPosition), circleRadius, circlePaint);

    final textPainter = TextPainter(
      text: TextSpan(
        text: '✔',
        style: TextStyle(
          color: Colors.teal,
          fontSize: circleRadius,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
        canvas,
        Offset(circleXPosition - (textPainter.width / 2),
            circleYPosition - (textPainter.height / 2)));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

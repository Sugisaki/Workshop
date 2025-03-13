import 'dart:math';
import 'package:flutter/material.dart';

class ChargingProgress2 extends StatefulWidget {
  final double value;
  final Color color;
  final Color backgroundColor;
  final double strokeWidth;
  final double endCapRadius;

  ChargingProgress2({
    required this.value,
    this.color = Colors.blue,
    this.backgroundColor = Colors.grey,
    this.strokeWidth = 10.0,
    this.endCapRadius = 15.0, // バーの幅より大きい円の半径
  });

  @override
  _ChargingProgress2State createState() =>
      _ChargingProgress2State();
}

class _ChargingProgress2State extends State<ChargingProgress2>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: widget.value).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    )..addListener(() {
      setState(() {});
    });
    _controller.forward();
  }

  @override
  void didUpdateWidget(ChargingProgress2 oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _animation = Tween<double>(begin: _animation.value, end: widget.value).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
      )..addListener(() {
        setState(() {});
      });
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CircularProgressBarPainter(
        value: _animation.value,
        color: widget.color,
        backgroundColor: widget.backgroundColor,
        strokeWidth: widget.strokeWidth,
        endCapRadius: widget.endCapRadius,
      ),
      size: Size.square(widget.endCapRadius * 2 + widget.strokeWidth), // サイズ調整
    );
  }
}

class _CircularProgressBarPainter extends CustomPainter {
  final double value;
  final Color color;
  final Color backgroundColor;
  final double strokeWidth;
  final double endCapRadius;

  _CircularProgressBarPainter({
    required this.value,
    required this.color,
    required this.backgroundColor,
    required this.strokeWidth,
    required this.endCapRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2 - strokeWidth / 2;
    final startAngle = -pi / 2;
    final sweepAngle = 2 * pi * value;

    // 背景の円
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(center, radius, backgroundPaint);

    // 進捗の円弧
    final foregroundPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt; // 線端をbuttにする

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      foregroundPaint,
    );

    // 円弧の先端の円
    final endCapPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final endCapAngle = startAngle + sweepAngle;
    final endCapX = center.dx + radius * cos(endCapAngle);
    final endCapY = center.dy + radius * sin(endCapAngle);

    canvas.drawCircle(Offset(endCapX, endCapY), endCapRadius, endCapPaint);
  }

  @override
  bool shouldRepaint(_CircularProgressBarPainter oldDelegate) {
    return oldDelegate.value != value ||
        oldDelegate.color != color ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.endCapRadius != endCapRadius;
  }
}
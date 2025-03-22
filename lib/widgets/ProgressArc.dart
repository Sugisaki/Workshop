import 'dart:math' as math;
import 'package:flutter/material.dart';

// プログレスバー（円弧）
class ProgressArc extends StatefulWidget {
  final double progress; // 進捗度
  final Color color; // 色
  final double strokeWidth; // 線の太さ
  final double endCapRadius; // 終端円の大きさ
  final double startAngle; // 円弧の始点
  final double endAngle; // 円弧の終点
  final VoidCallback? onAnimationCompleted;
  final GlobalKey<ProgressArcState> key;

  const ProgressArc({
    required this.progress,
    required this.color,
    this.strokeWidth = 10.0,
    this.endCapRadius = 15.0,
    this.startAngle = - math.pi,
    this.endAngle = 0,
    this.onAnimationCompleted,
    required this.key,
  }) : super(key: key);

  @override
  ProgressArcState createState() => ProgressArcState();
}

class ProgressArcState extends State<ProgressArc>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  void resetAnimation() {
    debugPrint("@@@ リセットアニメ @@@");
    _animationController.value = 0.0;
    _animationController.forward();
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _animation = Tween<double>(begin: 0, end: widget.progress).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (_animation.value == widget.progress && widget.onAnimationCompleted != null) {
          widget.onAnimationCompleted!();
        }
      }
    });
    _animationController.forward();
  }

  @override
  void didUpdateWidget(ProgressArc oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.progress != widget.progress) {
      _animation = Tween<double>(begin: _animation.value, end: widget.progress).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
      );
      _animationController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          painter: _ProgressArcPainter(
            value: _animation.value,
            color: widget.color,
            strokeWidth: widget.strokeWidth,
            endCapRadius: widget.endCapRadius,
            startAngle: widget.startAngle,
            endAngle: widget.endAngle,
          ),
        );
      },
    );
  }
}

class _ProgressArcPainter extends CustomPainter {
  final double value;
  final Color color;
  final double strokeWidth;
  final double endCapRadius;
  final double startAngle;
  final double endAngle;

  _ProgressArcPainter({
    required this.value,
    required this.color,
    required this.strokeWidth,
    required this.endCapRadius,
    required this.startAngle,
    required this.endAngle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 円弧を描画
    final rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: math.min(size.width, size.height) / 2 - strokeWidth / 2,
    );
    final foregroundPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    final sweepAngle = (endAngle - startAngle) * value;
    canvas.drawArc(rect, startAngle, sweepAngle, false, foregroundPaint);

    // 円弧の先端のキャップを描画
    final endCapPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final radius = rect.shortestSide / 2; // ここで radius を取得
    final endCapAngle = startAngle + sweepAngle;
    final endCapX = rect.center.dx + radius * math.cos(endCapAngle);
    final endCapY = rect.center.dy + radius * math.sin(endCapAngle);
    canvas.drawCircle(Offset(endCapX, endCapY), endCapRadius, endCapPaint);
  }

  @override
  bool shouldRepaint(_ProgressArcPainter oldDelegate) {
    return oldDelegate.value != value || oldDelegate.color != color;
  }
}

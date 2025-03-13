import 'package:flutter/material.dart';

class ChargingProgressIndicator extends StatefulWidget {
  @override
  _ChargingProgressIndicatorState createState() =>
      _ChargingProgressIndicatorState();
}

class _ChargingProgressIndicatorState
    extends State<ChargingProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CircularProgressIndicator(
          value: _animation.value,
        );
      },
    );
  }
}
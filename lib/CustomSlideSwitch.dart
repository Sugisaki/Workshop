import 'package:flutter/material.dart';

/// ととと
class CustomSlideSwitch extends StatefulWidget {
  final double trackWidth; // トラックのサイズ
  final double knobSize; // ノブのサイズ
  final double frameSize; // 枠のサイズ
  final Color trackColor; // トラックの色
  final Color knobColor; // ノブの色
  final Color coverColor; // ノブの下のカバーの色
  final String trackText; // トラックに表示する文字
  final double fontSize; // フォントサイズ
  final VoidCallback? onSlideLeft; // 左端コールバック関数
  final VoidCallback? onSlideRight; // 右端コールバック関数

  const CustomSlideSwitch({
    super.key,
    this.trackWidth = 300,
    this.knobSize = 80,
    this.frameSize = 14,
    this.trackColor = Colors.teal,
    this.knobColor = Colors.white,
    this.coverColor = Colors.orange,
    this.trackText = 'スライドで充電開始',
    this.onSlideLeft,
    this.onSlideRight,
    this.fontSize = 14,
  });

  @override
  _CustomSlideSwitchState createState() => _CustomSlideSwitchState();
}

class _CustomSlideSwitchState extends State<CustomSlideSwitch>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  double _dragPosition = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300), // アニメーションの速度
    );
    _animation = Tween<double>(begin: 0, end: 0).animate(_animationController)
      ..addListener(() {
        setState(() {
          _dragPosition = _animation.value;
        });
      });
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // アニメーション完了時にコールバックを実行
        if (_animation.value == 0 && widget.onSlideLeft != null) {
          widget.onSlideLeft!();
        } else if (_animation.value == widget.trackWidth - widget.knobSize &&
            widget.onSlideRight != null) {
          widget.onSlideRight!();
        }
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onDragUpdate(DragUpdateDetails details) {
    setState(() {
      _dragPosition = (_dragPosition + details.delta.dx)
          .clamp(0, widget.trackWidth - widget.knobSize);
    });
  }

  void _onDragEnd(DragEndDetails details) {
    // ノブを中央より左で離すとアニメーションで左端に移動、右で離すと右端に移動させる
    double targetPosition =
        _dragPosition > (widget.trackWidth - widget.knobSize) / 2
            ? widget.trackWidth - widget.knobSize
            : 0;
    _animation = Tween<double>(begin: _dragPosition, end: targetPosition)
        .animate(_animationController);
    _animationController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: widget.trackWidth + widget.frameSize,
      height: widget.knobSize  + widget.frameSize,
      decoration: BoxDecoration(
        color: widget.trackColor,
        borderRadius: BorderRadius.circular(widget.knobSize / 2 + widget.frameSize),
      ),
      child: GestureDetector(
        onHorizontalDragUpdate: _onDragUpdate,
        onHorizontalDragEnd: _onDragEnd,
        child: Container(
          width: widget.trackWidth,
          height: widget.knobSize,
          decoration: BoxDecoration(
            // トラック
            color: widget.trackColor,
            borderRadius: BorderRadius.circular(widget.knobSize / 2),
          ),
          child: Stack(
            // トラック、カバー、ノブを重ねて配置
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  // トラックの文字
                  padding: EdgeInsets.only(left: widget.knobSize + widget.frameSize + widget.fontSize / 2 ),
                  child: Text(
                    widget.trackText,
                    style: TextStyle(
                      fontSize: widget.fontSize,
                      fontWeight: FontWeight.bold,
                      color: widget.knobColor
                    ),
                  ),
                ),
              ),
              Positioned(
                // カバー
                left: 0,
                child: Container(
                  width: _dragPosition + widget.knobSize,
                  height: widget.knobSize,
                  decoration: BoxDecoration(
                    color: widget.coverColor,
                    borderRadius: BorderRadius.circular(widget.knobSize / 2),
                  ),
                ),
              ),
              Positioned(
                // ノブ
                left: _dragPosition,
                child: Container(
                  width: widget.knobSize,
                  height: widget.knobSize,
                  decoration: BoxDecoration(
                    color: widget.knobColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

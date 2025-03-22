import 'package:flutter/material.dart';

class DrumRollNumbers extends StatefulWidget {
  final List<int> initialNumbers; // 数字の初期値
  final double fontSize; // フォントサイズ
  final Color textColor; // テキスト色
  final int columnNum; // カラム数
  final GlobalKey<DrumRollNumbersState>? key;

  const DrumRollNumbers({
    this.initialNumbers = const [0, 0],
    this.fontSize = 60.0,
    this.textColor = Colors.white,
    this.columnNum = 2,
    this.key
  }) : super(key: key);

  @override
  DrumRollNumbersState createState() => DrumRollNumbersState();
}

class DrumRollNumbersState extends State<DrumRollNumbers> {
  late final List<List<int>> numbers;
  late final List<FixedExtentScrollController> controllers;

  @override
  void initState() {
    super.initState();
    // コントローラを初期化
    controllers = List.generate(widget.columnNum,
          (index) => FixedExtentScrollController(
              initialItem: widget.initialNumbers.length > index ? widget.initialNumbers[index] : 0
          ),
    );
    // 0から9のリストを作成
    numbers = List.generate(widget.columnNum,
          (index) => List.generate(10, (index) => index)
    );
    initRolling(); // 最初の位置に戻す
  }

  void initRolling() {
    // 指定された桁数分の初期値をセット
    for (int i = 0; i < controllers.length; i++) {
      if (widget.initialNumbers.length > i) {
        controllers[i].jumpToItem(widget.initialNumbers[i]);
      }
    }
  }

  void startRolling(List<int> numbers) {
    // 最初の位置に戻す
    initRolling();
    // 各桁を回転させる
    for (int i = 0; i < controllers.length; i++) {
      controllers[i].animateToItem(
        numbers[i],
        duration: const Duration(milliseconds: 1200),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.fontSize * widget.columnNum,
      color: Colors.transparent,
      child: Row(
        // 数字のドラム（ホイール）を横並びで表示
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(controllers.length, (index) {
          return Transform.translate(
            // 横のドラムとの間隔を狭くしたいので、マイナスオフセットで右に詰める
            offset: Offset(
              (controllers.length -1 -index)* widget.fontSize * 0.4,
              0
            ),
            child: Container(
              width: widget.fontSize,
              height: double.infinity ,
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: ListWheelScrollView.useDelegate(
                // 数字のドラム（ホイール）
                controller: controllers[index],
                itemExtent: widget.fontSize * 1.4,
                physics: const FixedExtentScrollPhysics(),
                childDelegate: ListWheelChildLoopingListDelegate(
                  children: numbers[index].map((int num) => Text(
                    num.toString(),
                    style: TextStyle(
                      color: widget.textColor,
                      fontSize: widget.fontSize,
                      fontWeight: FontWeight.normal
                    ),
                  )).toList(),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

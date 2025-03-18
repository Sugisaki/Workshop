import 'package:flutter/material.dart';

/*
  TODO ドラムはタッチできないようにしよう
  TODO 桁が2桁じゃなかったらエラーにしよう
 */

class DrumRollNumber extends StatefulWidget {
  final List<int> initialNumbers; // 数字の初期値
  final double fontSize; // フォントサイズ
  final Color textColor; // テキスト色
  final GlobalKey<DrumRollNumberState> key;

  const DrumRollNumber({
    this.initialNumbers = const [0, 0],
    this.fontSize = 60.0,
    this.textColor = Colors.white,
    required this.key
  }) : super(key: key);

  @override
  DrumRollNumberState createState() => DrumRollNumberState();
}

class DrumRollNumberState extends State<DrumRollNumber> {
  final List<List<int>> numbers = [
    List.generate(10, (index) => index), // 左の桁
    List.generate(10, (index) => index), // 右の桁
  ];
  late final List<FixedExtentScrollController> controllers;

  @override
  void initState() {
    super.initState();
    controllers = [
      FixedExtentScrollController(initialItem: widget.initialNumbers[0]),
      FixedExtentScrollController(initialItem: widget.initialNumbers[1]),
    ];
    initRolling(); // 最初の位置に戻す
  }

  void initRolling() {
    controllers[0].jumpToItem(widget.initialNumbers[0]); // 左側の桁の初期値
    controllers[1].jumpToItem(widget.initialNumbers[1]); // 右側の桁の初期値
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
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Row(
        // 数字のドラム（ホイール）を横並びで表示
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(controllers.length, (index) {
          return Transform.translate(
            // 横のドラムとの間隔を狭くしたいので、マイナスオフセット
            offset: Offset(-index * widget.fontSize * 0.4, 0),
            child: Container(
              width: widget.fontSize,
              height: double.infinity ,
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: ListWheelScrollView.useDelegate(
                // 数字のドラム（ホイール）
                controller: controllers[index],
                itemExtent: widget.fontSize + 10,
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

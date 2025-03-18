import 'package:flutter/material.dart';

/*
  TODO ドラムはタッチできないようにしよう
  TODO 桁が2桁じゃなかったらエラーにしよう
  TODO 初期値が　00 になる問題あり
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

  final List<FixedExtentScrollController> controllers = [
    FixedExtentScrollController(initialItem: 0),
    FixedExtentScrollController(initialItem: 0),
  ];

  @override
  void initState() {
    super.initState();
    initRolling(); // 最初の位置に戻す
    print("@@@ initState @@@");
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
        duration: Duration(milliseconds: 1200),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(controllers.length, (index) {
            return Transform.translate( // 少し重ねて数字の間を狭くする
              offset: Offset(-index * (widget.fontSize * 0.4), 0),
              child: Container(
                width: widget.fontSize,
                height: double.infinity ,
                //margin: EdgeInsets.symmetric(horizontal: 0),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListWheelScrollView.useDelegate(
                  controller: controllers[index],
                  itemExtent: widget.fontSize + 10,
                  physics: FixedExtentScrollPhysics(),
                  childDelegate: ListWheelChildLoopingListDelegate(
                    children: numbers[index].map((num) => Center(
                      child: Text(
                        num.toString(),
                        style: TextStyle(
                          color: widget.textColor,
                          fontSize: widget.fontSize,
                          fontWeight: FontWeight.normal),
                      ),
                    )).toList(),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

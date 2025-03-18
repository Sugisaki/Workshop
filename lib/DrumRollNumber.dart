import 'dart:async';
import 'package:flutter/material.dart';

class DrumRollNumber extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SlotMachineScreen(),
    );
  }
}

class SlotMachineScreen extends StatefulWidget {
  @override
  _SlotMachineScreenState createState() => _SlotMachineScreenState();
}

class _SlotMachineScreenState extends State<SlotMachineScreen> {
  final List<List<int>> numbers = [
    List.generate(10, (index) => index), // 1桁目（下→上）
    List.generate(10, (index) => 9 - index), // 2桁目（上→下）
  ];
  static const int columnLength = 2;

  final List<FixedExtentScrollController> controllers = List.generate(
      columnLength, (_) => FixedExtentScrollController());

  @override
  void initState() {
    super.initState();
    _startRolling();
  }

  void _startRolling() {
    for (int i = 0; i < controllers.length; i++) {
      Timer(Duration(milliseconds: 500 * i), () {
        controllers[i].animateToItem(
          numbers[i].length - 1, // 各桁ごとに回す
          duration: Duration(seconds: 2 + i),
          curve: Curves.easeOut,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(columnLength, (index) {
            return Container(
              width: 50,
              height: 100,
              margin: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListWheelScrollView.useDelegate(
                controller: controllers[index],
                itemExtent: 40,
                physics: FixedExtentScrollPhysics(),
                childDelegate: ListWheelChildLoopingListDelegate(
                  children: numbers[index].map((num) => Center(
                    child: Text(
                      num.toString(),
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  )).toList(),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

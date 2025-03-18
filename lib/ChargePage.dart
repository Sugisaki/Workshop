import 'package:flutter/material.dart';
import 'package:workshop/CustomSlideSwitch.dart';

class ChargePage extends StatelessWidget {
  final Function() startCharge; // 充電開始
  const ChargePage({required this.startCharge});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Charge Page'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('スライドで充電開始'),
            CustomSlideSwitch(
              trackTextToRight: 'スライドで充電開始',
              onSlideRight: () {
                startCharge(); // 充電開始
                Navigator.pop(context); // 画面を閉じる
              },
            ),
          ],
        ),
      ),
    );
  }
}
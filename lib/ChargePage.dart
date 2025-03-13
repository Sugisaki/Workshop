import 'package:flutter/material.dart';

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

            // 充電開始ボタン
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // 画面を閉じる
                startCharge(); // 充電開始
              },
              child: Text("充電を開始する"),
            ),

          ],
        ),
      ),
    );
  }
}
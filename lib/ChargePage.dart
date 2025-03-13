import 'package:flutter/material.dart';

class ChargePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Page'),
      ),
      body: Center(
        child: Column(
          children: [

            Text("充電を開始する"),
            Text('スライドで充電開始'),

          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:workshop/ProgressArc.dart';
import 'package:workshop/ChargePage.dart';
import 'package:workshop/DrumRollNumber.dart';
import 'package:workshop/MainFooter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final GlobalKey<ProgressArcState> _progressArcKey = GlobalKey<ProgressArcState>();

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;

      _progressArcKey.currentState!.resetAnimation(); // アニメーション
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [ // 背景の緑色のグラデーション
              Color(0xFF3D8F60),
              Color(0xFF49706E),
              Color(0xFF3C8766),
            ],
            stops: [
              0.0,
              0.6,
              1.0,
            ],
          ),
        ),

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Stack(
                children: [
                  SizedBox(
                    width: 300,
                    height: 300,
                    child: ProgressArc(
                      progress: 0.75,
                      color: Colors.green,
                      strokeWidth: 12.0,
                      endCapRadius: 18.0,
                      startAngle: - math.pi * 1 / 2 +(math.pi * 0.2),
                      endAngle: math.pi * 3 / 2 -(math.pi * 0.2),
                      key: _progressArcKey,
                    ),
                  ),
                  Positioned(
                    top: 50,
                    left: 50,
                    child: SizedBox(
                        width: 200,
                        height: 200,
                        child: DrumRollNumber()
                    )
                  )
                ],
              ),

              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
      ),

      persistentFooterButtons: [
        ElevatedButton( // 充電ボタン
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChargePage(
                  // 充電ができているようなアニメーションを表示
                  startCharge: _progressArcKey.currentState!.resetAnimation
                ),
              ),
            );
          },
          child: Text('充電'),
        ),
        ElevatedButton(
          onPressed: () {
            // ボタン2の処理
          },
          child: Text('Button 2'),
        ),
      ],

      bottomNavigationBar: MainFooter(
        buttons: [
          FooterButtonItem(
            icon: Icons.person,
            label: 'マイページ',
            onPressed: () {
              print('マイページボタンが押されました');
            },
          ),
          FooterButtonItem(
            icon: Icons.charging_station,
            label: '充電',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChargePage(
                    // 充電ができているようなアニメーションを表示
                      startCharge: _progressArcKey.currentState!.resetAnimation
                  ),
                ),
              );
            },
          ),
          FooterButtonItem(
            icon: Icons.notifications,
            label: 'お知らせ',
            onPressed: () {
              print('お知らせボタンが押されました');
            },
          ),
          FooterButtonItem(
            icon: Icons.help_center_outlined,
            label: 'ヘルプ',
            onPressed: () {
              print('ヘルプボタンが押されました');
            },
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

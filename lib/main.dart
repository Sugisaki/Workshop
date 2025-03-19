import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:workshop/ProgressArc.dart';
import 'package:workshop/ChargePage.dart';
import 'package:workshop/DrumRollNumber.dart';
import 'package:workshop/MainFooter.dart';
import 'package:workshop/CustomSlideSwitch.dart';

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
  final GlobalKey<DrumRollNumberState> _drumKey = GlobalKey<DrumRollNumberState>();

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;

      _progressArcKey.currentState!.resetAnimation(); // アニメーション
      _drumKey.currentState!.startRolling([0, 9]); // アニメーション
    });
  }
  void _startAnimation() {
    _progressArcKey.currentState!.resetAnimation(); // アニメーション
    _drumKey.currentState!.startRolling([0, 9]); // アニメーション
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
                    width: 240,
                    height: 240,
                    child: ProgressArc(
                      progress: 1.00,
                      color: Colors.white,
                      strokeWidth: 12.0,
                      endCapRadius: 14.0,
                      startAngle: - math.pi * 1 / 2 +(math.pi * 0.2), // 1時の方向
                      endAngle: math.pi * 3 / 2 -(math.pi * 0.2), // 11時の方向
                      key: _progressArcKey,
                    ),
                  ),
                  Positioned(
                    top: 80,
                    left: 20,
                    child: SizedBox(
                        width: 240,
                        height: 80,
                        child: Row(
                          children: [
                            Expanded(
                              child: DrumRollNumber(
                                initialNumbers: const [9, 0],
                                //textColor: Colors.white,
                                fontSize: 60.0,
                                key: _drumKey,
                              ),
                            ),
                            const Expanded(
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Text("%",
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal
                                  )
                                ),
                              ),
                            ),
                          ],
                        )
                    )
                  )
                ],
              ),

              CustomSlideSwitch(
                initalRight: true, // ノブは右に寄せておく
                trackColor: Color(0xFFC78525),
                knobColor: Colors.white,
                coverColor: Color(0xFFC78525),
                trackTextToLeft: 'スライドで充電完了',
                onSlideRight: () {
                  print("右>>>");
                },
                onSlideLeft: () {
                  print("<<<左");
                },
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
                  startCharge: _startAnimation
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
                    startCharge: _startAnimation
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

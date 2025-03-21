import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

import 'package:workshop/ProgressArc.dart';
import 'package:workshop/ChargePage.dart';
import 'package:workshop/DrumRollNumber.dart';
import 'package:workshop/MainFooter.dart';
import 'package:workshop/CustomSlideSwitch.dart';
import 'package:workshop/EnagyInfo.dart';
import 'package:workshop/ChargingButtons.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // 縦向きのみ許可
  ]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ProgressArcState> _progressArcKey =
      GlobalKey<ProgressArcState>();
  final GlobalKey<DrumRollNumberState> _drumKey =
      GlobalKey<DrumRollNumberState>();

  void _startAnimation() {
    _progressArcKey.currentState!.resetAnimation(); // アニメーション
    _drumKey.currentState!.startRolling([0, 9]); // アニメーション
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    // 各テキストスタイルのフォントサイズを確認
    print('Headline Large: ${textTheme.headlineLarge?.fontSize}');
    print('Headline Medium: ${textTheme.headlineMedium?.fontSize}');
    print('Headline Small: ${textTheme.headlineSmall?.fontSize}');
    print('Title Large: ${textTheme.titleLarge?.fontSize}');
    print('Title Medium: ${textTheme.titleMedium?.fontSize}');
    print('Title Small: ${textTheme.titleSmall?.fontSize}');
    print('Body Large: ${textTheme.bodyLarge?.fontSize}');
    print('Body Medium: ${textTheme.bodyMedium?.fontSize}');
    print('Body Small: ${textTheme.bodySmall?.fontSize}');
    print('Label Large: ${textTheme.labelLarge?.fontSize}');
    print('Label Medium: ${textTheme.labelMedium?.fontSize}');
    print('Label Small: ${textTheme.labelSmall?.fontSize}');

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                // 背景の緑色のグラデーション
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
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              print("@@@@幅　　${constraints.maxWidth}");
              print("@@@ 高さ　${constraints.maxWidth}");
              double screenWidth = constraints.maxWidth;
              double progressArcSize = screenWidth * 0.57;
              double slideSize = screenWidth * 0.71;

              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  // 充電中マーク
                  Container(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Container(
                            width: 38,
                            height: 38,
                            decoration: const BoxDecoration(
                              color: Color(0xFFE6CF00),
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Icon(Icons.bolt, size: 30, color: Color(0xFF3D8F60)),
                            ),
                          ),
                          Text("ただいま充電中",
                              style: TextStyle(
                                fontSize: textTheme.labelSmall?.fontSize,
                                color: Colors.white,
                              )
                          )
                        ],
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      // プログレス円弧
                      SizedBox(
                        width: progressArcSize,
                        height: progressArcSize,
                        child: ProgressArc(
                          progress: 1.00,
                          color: Colors.white,
                          strokeWidth: 9.0,
                          endCapRadius: 10.0,
                          startAngle: -math.pi * 1 / 2 + (math.pi * 0.2), // 1時の方向
                          endAngle: math.pi * 3 / 2 - (math.pi * 0.2), // 11時の方向
                          key: _progressArcKey,
                        ),
                      ),
                      Positioned(
                        top: progressArcSize / 4,
                        left: screenWidth / 12,
                        child: SizedBox(
                          width: progressArcSize,
                          height: progressArcSize / 3, //_screenWidth / 6,
                          child: Row(
                            children: [
                              // ドラムロール
                              Expanded(
                                child: DrumRollNumber(
                                  initialNumbers: const [9, 0],
                                  //textColor: Colors.white,
                                  fontSize: screenWidth / 8,
                                  key: _drumKey,
                                ),
                              ),
                              // 単位 %
                              Expanded(
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    "%",
                                    style: TextStyle(
                                      fontSize: screenWidth / 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // 残り分
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: progressArcSize / 4,
                        child: Container(
                          //color: Colors.amberAccent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("残り",
                                style: TextStyle(color: Colors.white),
                              ),
                              Container(
                                width: 20,
                                child: Text(" 0",
                                  style: TextStyle(
                                    fontSize: textTheme.bodyLarge?.fontSize,
                                    color: Colors.white
                                  ),
                                ),
                              ),
                              const Text("分",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  // スライドスイッチ
                  CustomSlideSwitch(
                    trackWidth: slideSize,
                    knobSize: slideSize / 4,
                    frameSize: slideSize / 20,
                    fontSize: slideSize / 20,
                    initalRight: true, // ノブは右に寄せておく
                    trackColor: const Color(0xFFC78525),
                    knobColor: Colors.white,
                    coverColor: const Color(0xFFC78525),
                    trackTextToLeft: 'スライドで充電完了',
                    onSlideRight: () {
                      print("右>>>");
                    },
                    onSlideLeft: () {
                      print("<<<左");
                    },
                  ),
                  const SizedBox(height: 16.0),
                  // 情報表示
                  EnergyInfo(screenWidth: screenWidth),
                  const SizedBox(height: 16.0),
                  // 充電ボタン
                  ChargingButtons(screenWidth: screenWidth),
                ],
              );
            },
          ),
        ),
      ),
      // フッター
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
            icon: Icons.bolt,
            label: '充電',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ChargePage(startCharge: _startAnimation),
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
      // フローティングボタンに自動車アイコン（アニメーションをスタート）
      floatingActionButton: FloatingActionButton(
        onPressed: _startAnimation,
        tooltip: 'Increment',
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(36.0),
          side: const BorderSide(
            color: Color(0xFF3C8C60),
            width: 4.0,
          ),
        ),
        elevation: 10,
        child: const Icon(
          Icons.directions_car_filled_outlined,
          color: Color(0xFF3C8C60),
          size: 36,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

import 'package:flutter/material.dart';

import 'package:workshop/widgets/CustomSlideSwitch.dart';
import 'package:workshop/functions/CustomDialog.dart';

class ChargePage extends StatelessWidget {
  final Function() startCharge; // 充電開始
  const ChargePage({
    super.key,
    required this.startCharge
  });
  static const Color pageColor1 = Color(0xFF476E6F);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        double iconSize = screenWidth * 0.08;
        double fontSize = screenWidth * 0.05;
        double slideSize = screenWidth * 0.71;
        Color textColor = Color(0xFF476E6F);

        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              // トップに閉じるアイコン
              Positioned(
                top: 0,
                child: SizedBox(
                  width: screenWidth,
                  height: screenWidth / 4 + iconSize,
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    color: textColor,
                    child: IconButton(
                      icon: Icon(Icons.close,
                        color: Colors.white,
                        size: iconSize,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ),
              // 白抜きの充電マーク
              Positioned(
                top: screenWidth / 4,
                left: (screenWidth - iconSize * 2) / 2,
                child: Container(
                  width: iconSize * 2,
                  height: iconSize * 2,
                  decoration: BoxDecoration(
                    color: textColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 8),
                  ),
                  child: Center(
                    child: Icon(Icons.bolt, size: iconSize * 1.2, color: Colors.white),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: screenWidth * 0.5),
                  Text('充電を開始する',
                    style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: textColor),
                  ),
                  SizedBox(height: screenWidth * 0.03),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('あと2回の充電で来月も',
                        style: TextStyle(fontSize: fontSize * 0.6, color: textColor),
                      ),
                      Text('GOLD会員',
                        style: TextStyle(
                          fontSize: fontSize * 0.6, color: Colors.amber, fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('です',
                        style: TextStyle(fontSize: fontSize * 0.6, color: textColor),
                      ),
                    ],
                  ),
                  SizedBox(height: screenWidth * 0.05),
                  // スライドスイッチ
                  CustomSlideSwitch(
                    trackWidth: slideSize,
                    knobSize: slideSize / 4,
                    frameSize: slideSize / 20,
                    fontSize: slideSize / 20,
                    trackColor: textColor,
                    knobColor: Colors.white,
                    coverColor: textColor,
                    trackTextToRight: 'スライドで充電開始',
                    onSlideRight: () {
                      // ダイアログを挟む
                      showCoffeeCoupon(
                          context,
                          pageColor1,
                          () {
                            startCharge(); // 充電開始
                            Navigator.pop(context); // 画面を閉じる
                          }
                      );
                    },
                  ),
                  SizedBox(height: screenWidth * 0.03),

                  Text('プラグが接続されているか確認してください',
                    style: TextStyle(
                      fontSize: fontSize * 0.7,
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenWidth * 0.02),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                          activeColor: textColor,
                          value: true, onChanged: (value) {}
                      ),
                      Text('いつもの充電で充電する',
                        style: TextStyle(
                          fontSize: fontSize * 1.0,
                          color: textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenWidth * 0.03),

                  Container(
                    width: screenWidth * 0.9,
                    padding: EdgeInsets.symmetric(vertical: fontSize),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Text('スタシオン横浜中央',
                          style: TextStyle(fontSize: fontSize * 0.8, fontWeight: FontWeight.bold, color: textColor),
                        ),
                        SizedBox(height: screenWidth * 0.01),
                        Text('〒105-0011 神奈川県横浜市中区千歳町2-10',
                            style: TextStyle(fontSize: fontSize * 0.6, color: textColor)),
                      ],
                    ),
                  ),
                  SizedBox(height: screenWidth * 0.05),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Column(
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(text:'30',
                                  style: TextStyle(fontSize: fontSize * 1.5, fontWeight: FontWeight.bold, color: textColor),
                                ),
                                TextSpan(text: 'kW',
                                  style: TextStyle(fontSize: fontSize * 0.8, color: textColor),
                                ),
                              ],
                            ),
                          ),
                          Text('出力電力',
                            style: TextStyle(fontSize: fontSize * 0.6, fontWeight: FontWeight.bold, color: textColor),
                          ),
                        ],
                      ),
                      Container(height: fontSize * 2, width: 1, color: Colors.black12),
                      Column(
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(text:'20',
                                  style: TextStyle(fontSize: fontSize * 1.5, fontWeight: FontWeight.bold, color: textColor),
                                ),
                                TextSpan(text: '分',
                                  style: TextStyle(fontSize: fontSize * 0.8, color: textColor),
                                ),
                              ],
                            ),
                          ),
                          Text('充電時間',
                            style: TextStyle(fontSize: fontSize * 0.6, fontWeight: FontWeight.bold, color: textColor),
                          ),
                        ],
                      ),
                      Container(height: fontSize * 2, width: 1, color: Colors.black12),
                      Column(
                        children: [
                          Image.asset('assets/workshop_plug_icon.png', width: fontSize * 1.8, height: fontSize * 1.8),
                          Text('コネクタタイプ',
                            style: TextStyle(fontSize: fontSize * 0.6, fontWeight: FontWeight.bold, color: textColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: screenWidth * 0.05),

                  Text('決済方法: いつものクレジットカード',
                    style: TextStyle(
                      fontSize: fontSize * 0.6,
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('xxxx - xxxx - xxxx - 0000',
                    style: TextStyle(
                      fontSize: fontSize * 0.6,
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const Spacer(),

                  // フッター
                  Container(
                    padding: EdgeInsets.symmetric(vertical: screenWidth * 0.03),
                    decoration: BoxDecoration(color: Colors.grey[300]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildFooterItem('前回の利用日', '5/30', textColor, fontSize),
                        Container(height: fontSize * 2, width: 1, color: Colors.white),
                        _buildFooterItem('前回の利用金額', '6,000円', textColor, fontSize),
                        Container(height: fontSize * 2, width: 1, color: Colors.white),
                        _buildFooterItem('前回の充電時間', '20分', textColor, fontSize),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
  // フッター生成用
  Widget _buildFooterItem(String title, String value, Color textColor, double fontSize) {
    return Column(
      children: [
        Text(title, style: TextStyle(fontSize: fontSize * 0.6, color: textColor)),
        SizedBox(height: 4),
        Text(value, style: TextStyle(fontSize: fontSize * 0.8, fontWeight: FontWeight.bold, color: textColor)),
      ],
    );
  }
}

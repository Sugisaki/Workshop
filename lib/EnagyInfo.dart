import 'package:flutter/material.dart';

class EnergyInfo extends StatelessWidget {
  final double screenWidth;

  EnergyInfo({required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    double fontSizeLarge = screenWidth * 0.07; // メインの大きな数値
    double fontSizeSmall = screenWidth * 0.035; // サブテキスト
    double dividerHeight = fontSizeLarge * 2; // 区切り線の高さ

    return Container(
      width: screenWidth,
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildColumn("30", "kw", "出力電力", fontSizeLarge, fontSizeSmall),
          _buildDivider(dividerHeight),
          _buildColumn("12:30", "", "充電終了予定", fontSizeLarge, fontSizeSmall),
          _buildDivider(dividerHeight),
          _buildColumn("700", "円", "支払予定", fontSizeLarge, fontSizeSmall),
        ],
      ),
    );
  }

  Widget _buildColumn(String mainText, String unit, String subText, double mainSize, double subSize) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: mainText,
                style: TextStyle(fontSize: mainSize, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              if (unit.isNotEmpty)
                TextSpan(
                  text: unit,
                  style: TextStyle(fontSize: subSize, color: Colors.white),
                ),
            ],
          ),
        ),
        SizedBox(height: 5),
        Text(
          subText,
          style: TextStyle(fontSize: subSize, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildDivider(double height) {
    return Container(
      width: 1,
      height: height,
      color: Colors.white,
    );
  }
}

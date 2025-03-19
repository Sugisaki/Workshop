import 'package:flutter/material.dart';
import 'package:workshop/CustomSlideSwitch.dart';

class ChargePage extends StatelessWidget {
  final Function() startCharge; // 充電開始
  const ChargePage({required this.startCharge});
  static const Color pageColor1 = Color(0xFF476E6F);

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
                // ダイアログを挟む
                _showCustomDialog(context, () {
                      startCharge(); // 充電開始
                      Navigator.pop(context); // 画面を閉じる
                    }
                );
              },
            ),
          ],
        ),
      ),
    );
  }
  // クーポン券のダイアログ
  void _showCustomDialog(BuildContext context, Function onClose) {
    showDialog(
      context: context,
      barrierDismissible: false, // 外側タップで閉じないようにする
      builder: (BuildContext context) {
        // 画面のサイズを取得
        double screenWidth = MediaQuery.of(context).size.width;
        double screenHeight = MediaQuery.of(context).size.height;

        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          contentPadding: EdgeInsets.zero, // デフォルトのパディングを削除
          content: Stack(
            children: [
              // メインのコンテンツ
              SizedBox(
                width: screenWidth * 0.97, // 画面の幅
                height: screenHeight * 0.97, // 画面の高さ
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.check,
                      size: 200,
                      color: pageColor1,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 80, horizontal: 20),
                      child: Text(
                        "充電を開始しました",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: pageColor1,
                          fontSize: 24
                        ),
                      ),
                    ),
                    Spacer(),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(pageColor1)
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("いままでにGETしたクーポンを見る",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
              // 右上に閉じるボタン
              Positioned(
                right: 8,
                top: 8,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop(); // ダイアログを閉じる
                    onClose();
                  },
                  child: Container(
                    // 白抜きの閉じるボタン
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(
                      color: Colors.black12,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
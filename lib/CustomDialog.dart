import 'package:flutter/material.dart';

// コーヒークーポン券のダイアログ
void showCoffeeCoupon(BuildContext context, Color pageColor1, Function onClose) {
  showDialog(
    context: context,
    //barrierDismissible: false, // 外側タップで閉じないようにする
    builder: (BuildContext context) {
      // 画面のサイズを取得
      double screenWidth = MediaQuery.of(context).size.width;
      double screenHeight = MediaQuery.of(context).size.height;
      double fontSize = screenWidth * 0.03;

      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
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
                  Icon(Icons.check,
                    size: 200,
                    color: pageColor1,
                  ),
                  SizedBox(height: screenWidth * 0.05),

                  Text("充電を開始しました",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: pageColor1,
                      fontSize: fontSize * 1.3,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // クーポンの写真
                  Image.asset('assets/coffee_coupon.png'),
                  SizedBox(height: screenWidth * 0.05),
                  Text("アイスコーヒー一杯無料",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: pageColor1,
                      fontSize: fontSize * 1.4,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("2022.8.1(月)〜2022.10.31(月)",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: pageColor1,
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("1回の提示でおひとりさま1回ご利用いただけます",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: pageColor1,
                        fontSize: fontSize
                    ),
                  ),

                  const Spacer(),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4), // 角の丸みを変更
                      ),
                        backgroundColor: pageColor1
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // ダイアログを閉じる
                      onClose(); // コールバック
                    },
                    child: Text("今までにGETしたクーポンを見る",
                      style: TextStyle(
                        fontSize: fontSize * 1.1,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
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
                  onClose(); // コールバック
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

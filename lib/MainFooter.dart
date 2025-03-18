import 'package:flutter/material.dart';

class MainFooter extends StatelessWidget {
  final List<FooterButtonItem> buttons;

  MainFooter({required this.buttons});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF476E6F),
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: buttons.take(2).map((item) => _buildFooterButton(item)).toList(), // 左側のボタン
          ),
          Row(
            children: buttons.skip(2).take(2).map((item) => _buildFooterButton(item)).toList(), // 右側のボタン
          ),
        ],
      ),
    );
  }

  Widget _buildFooterButton(FooterButtonItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextButton(
        onPressed: item.onPressed, // 引数で渡された処理を呼び出す
        style: TextButton.styleFrom(
          backgroundColor: Color(0xFF476E6F),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              item.icon,
              color: Colors.white,
            ),
            Text(
              item.label,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class FooterButtonItem {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  FooterButtonItem({
    required this.icon,
    required this.label,
    required this.onPressed,
  });
}
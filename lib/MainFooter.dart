import 'package:flutter/material.dart';

class MainFooter extends StatelessWidget {
  final List<FooterButtonItem> buttons;
  const MainFooter({super.key,
    required this.buttons,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF476E6F),
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
    return TextButton(
      onPressed: item.onPressed, // ボタンが押されたときの処理
      style: TextButton.styleFrom(
        backgroundColor: const Color(0xFF476E6F),
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
import 'package:flutter/material.dart';

class MainButtons extends StatelessWidget {
  final double screenWidth;

  MainButtons({required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    double fontSize = screenWidth * 0.03;
    double buttonWidth = screenWidth * 0.45;
    double buttonHeight = screenWidth * 0.12;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButton(
          icon: Icons.ev_station,
          text: "使用中の充電器",
          fontSize: fontSize,
          width: buttonWidth,
          height: buttonHeight,
        ),
        _buildButton(
          icon: Icons.home,
          text: "充電クーポン",
          fontSize: fontSize,
          width: buttonWidth,
          height: buttonHeight,
        ),
      ],
    );
  }

  Widget _buildButton({
    required IconData icon,
    required String text,
    required double fontSize,
    required double width,
    required double height,
  }) {
    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.white, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          backgroundColor: Color(0x33FFFFFF),
        ),
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, color: Colors.white),
            Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: fontSize),
            ),
          ],
        ),
      ),
    );
  }
}

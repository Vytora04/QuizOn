import 'package:flutter/material.dart';
import '../utils/constants.dart';

class OptionButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final bool isSelected;
  final bool isCorrect;
  final bool showResult;

  const OptionButton({
    super.key,
    required this.text,
    required this.onTap,
    this.isSelected = false,
    this.isCorrect = false,
    this.showResult = false,
  });

  @override
  Widget build(BuildContext context) {
    Color? backgroundColor;
    Color? textColor;
    
    if (showResult) {
      if (isCorrect) {
        backgroundColor = Colors.green;
        textColor = Colors.white;
      } else if (isSelected && !isCorrect) {
        backgroundColor = Colors.red;
        textColor = Colors.white;
      } else {
        backgroundColor = Colors.grey[300];
        textColor = Colors.grey.shade700;
      }
    } else {
      backgroundColor = null;
      textColor = Colors.grey.shade900;
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: kSpacingS),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          padding: kPaddingM,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kRadiusM),
          ),
          elevation: kElevationS,
        ),
        onPressed: onTap,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
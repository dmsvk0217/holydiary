import 'package:flutter/material.dart';
import 'package:holydiary/view/resources/color_manager.dart';
import 'package:holydiary/view/resources/font_manager.dart';

class doneWriteButton extends StatelessWidget {
  const doneWriteButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        // Action to perform when the button is pressed
      },
      style: TextButton.styleFrom(
        backgroundColor: ColorManager.navBackground,
        padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        '작성완료',
        style: TextStyle(
          fontWeight: FontWeightManager.bold,
          fontSize: FontSize.s22,
          color: ColorManager.text,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:holydiary/controller/diary_controller.dart';
import 'package:holydiary/controller/user_controller.dart';
import 'package:holydiary/model/diary.dart';
import 'package:holydiary/view/resources/color_manager.dart';
import 'package:holydiary/view/resources/font_manager.dart';

class doneWriteButton extends StatelessWidget {
  doneWriteButton({
    Key? key,
  }) : super(key: key);

  final DiaryController diaryController = Get.put(DiaryController());
  final UserController userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        // Action to perform when the button is pressed
        Diary diary = Diary(
          content: userController.content.value,
          contentGPT: userController.contentGPT.value,
        );
        diaryController.addDiary(diary);
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

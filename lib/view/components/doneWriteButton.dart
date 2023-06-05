import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:holydiary/controller/diary_controller.dart';
import 'package:holydiary/controller/user_controller.dart';
import 'package:holydiary/model/diary.dart';
import 'package:holydiary/util.dart';
import 'package:holydiary/view/components/loadingdialog.dart';
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
      onPressed: () async {
        // Action to perform when the button is pressed

        try {
          MyLoadingDialog.show(context);
          userController.contentGPT.value =
              await generateText(userController.content.value);
          print("GPT답변 : ");
          print(userController.contentGPT.value);
          Diary diary = Diary(
            contentGPT: userController.contentGPT.value,
          );
          await diaryController.addDiary(diary);
          MyLoadingDialog.hide(context);
          userController.focusNode.unfocus();
        } catch (e) {
          print("Error on writing : $e");
        }
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

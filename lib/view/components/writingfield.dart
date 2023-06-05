import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:holydiary/controller/user_controller.dart';
import 'package:holydiary/view/resources/color_manager.dart';
import 'package:holydiary/view/resources/font_manager.dart';

class Writingfield extends StatelessWidget {
  Writingfield({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorManager.textfield,
        ),
        width: 350,
        height: 240,
        padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
        child: Column(
          children: [
            const TopText(),
            const SizedBox(height: 10),
            DiaryTextFiled(),
          ],
        ),
      ),
    );
  }
}

class DiaryTextFiled extends StatelessWidget {
  DiaryTextFiled({
    super.key,
  });

  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController(
      text: userController.content.value,
    );

    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          height: 155,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextFormField(
            focusNode: userController.focusNode,
            controller: textEditingController,
            onChanged: (value) {
              userController.content.value = value;
              textEditingController.text = value;
            },
            // maxLength: 10,
            maxLines: 50,
            style: TextStyle(
              color: ColorManager.text,
              fontWeight: FontWeightManager.medium,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}

class TopText extends StatelessWidget {
  const TopText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "영성일기",
          style: TextStyle(
            fontSize: FontSize.s14,
            fontWeight: FontWeightManager.bold,
            color: ColorManager.text,
          ),
        ),
      ],
    );
  }
}

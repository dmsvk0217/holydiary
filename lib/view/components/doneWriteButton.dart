import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:holydiary/controller/diary_controller.dart';
import 'package:holydiary/controller/user_controller.dart';
import 'package:holydiary/main.dart';
import 'package:holydiary/model/diary.dart';
import 'package:holydiary/util.dart';
import 'package:holydiary/view/components/loadingdialog.dart';
import 'package:holydiary/view/resources/color_manager.dart';
import 'package:holydiary/view/resources/font_manager.dart';
import 'package:holydiary/view/resources/getx_routes_manager.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class doneWriteButton extends StatelessWidget {
  doneWriteButton({
    Key? key,
  }) : super(key: key);

  final DiaryController diaryController = Get.put(DiaryController());
  final UserController userController = Get.put(UserController());

  Future<String> generateText(String prompt) async {
    String generatedText = "";

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $openaikey'
      },
      body: jsonEncode({
        //"model": "text-davinci-003",
        'prompt':
            "What is $prompt? Tell me like you're explaining to an eight-year-old.",
        'max_tokens': 100,
        'temperature': 0,
        'top_p': 1,
        // 'frequency_penalty': 0,
        // 'presence_penalty': 0
      }),
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      generatedText = data['choices'][0]['text'];
    } else {
      print(response.body);

      generatedText = "Error: ${response.body}";
    }

    return generatedText;
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        // Action to perform when the button is pressed

        try {
          MyLoadingDialog.show(context);
          userController.contentGPT.value =
              await generateText(userController.content.value);
          Diary diary = Diary(
            content: userController.content.value,
            contentGPT: userController.contentGPT.value,
          );
          await diaryController.addDiary(diary);
          MyLoadingDialog.hide(context);
        } catch (e) {
          print("Error on writing : $e");
        }

        // userController.bottomNavIndex.value = 0;
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

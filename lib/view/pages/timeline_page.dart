import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:holydiary/controller/diary_controller.dart';
import 'package:holydiary/model/diary.dart';
import 'package:holydiary/view/components/writedfield.dart';
import 'package:holydiary/view/resources/color_manager.dart';
import 'package:holydiary/view/resources/styles_manager.dart';
import 'package:intl/intl.dart';

class TimelinePage extends StatefulWidget {
  TimelinePage({super.key});

  @override
  State<TimelinePage> createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  final DiaryController diaryController = Get.put(DiaryController());

  static String formatToYYMM(DateTime dateTime) {
    final DateFormat formatter = DateFormat('yy년 MM월');
    return formatter.format(dateTime);
  }

  String selectedDateString = formatToYYMM(DateTime.now());
  DateTime selectedDate = DateTime.now();

  void onPressed() async {
    await showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.white,
            height: 300.0,
            child: Column(
              children: [
                Expanded(
                  child: CupertinoDatePicker(
                    showDayOfWeek: true,
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: selectedDate,
                    onDateTimeChanged: (DateTime date) {
                      setState(() {
                        selectedDateString = formatToYYMM(date);
                        selectedDate = date;
                      });
                    },
                  ),
                ),
                TextButton(
                  onPressed: () => Get.back(),
                  child: Text("확인"),
                ),
              ],
            ),
          ),
        );
      },
    );
    // Todo : getting select month diarylist on the oage
    diaryController.getdiaryMonthList(selectedDate);
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextButton(
            onPressed: onPressed,
            child: Text(
              selectedDateString,
              style: getMediumStyle(
                color: ColorManager.text,
              ),
            ),
          ),
          Obx(
            () => Expanded(
              child: ListView.builder(
                itemCount: diaryController.diaryMonthList.length,
                itemBuilder: (context, index) {
                  Diary diary = diaryController.diaryMonthList[index];
                  print("diaryController.diaryMonthList.length != 0");
                  print(diaryController.diaryMonthList.length != 0);
                  return diaryController.diaryMonthList.length != 0
                      ? Writedfield(diary: diary)
                      : Text(
                          "$selectedDateString의 일기가 존재하지 않습니다.",
                          style: getMediumStyle(
                            color: Colors.white,
                          ),
                        );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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

  String selectedDate = formatToYYMM(DateTime.now());

  void onPressed() async {
    final DateTime now = DateTime.now();

    await showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.white,
            height: 300.0,
            child: CupertinoDatePicker(
              showDayOfWeek: true,
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime.now(),
              onDateTimeChanged: (DateTime date) {
                setState(() {
                  selectedDate = formatToYYMM(date);
                });
              },
            ),
          ),
        );
      },
    );
    // getting select month diarylist
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextButton(
            onPressed: onPressed,
            child: Text(
              selectedDate,
              style: getMediumStyle(
                color: ColorManager.text,
              ),
            ),
          ),
          Obx(() => Expanded(
                child: ListView.builder(
                  itemCount: diaryController.diaryList.length,
                  itemBuilder: (context, index) {
                    Diary diary = diaryController.diaryList[index];
                    return diaryController.diaryList.length != 0
                        ? Writedfield(diary: diary)
                        : Text(
                            // "${DateFormat('MM월').format(selectedDay!)}의 일기가 존재하지 않습니다.",
                            "MM월의 일기가 존재하지 않습니다.",
                            style: getMediumStyle(
                              color: ColorManager.text,
                            ),
                          );
                  },
                ),
              )),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:holydiary/controller/diary_controller.dart';
import 'package:holydiary/model/diary.dart';
import 'package:holydiary/view/components/writedfield.dart';
import 'package:holydiary/view/resources/color_manager.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DiaryController diaryController = Get.put(DiaryController());
  DateTime? selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          TableCalendar(
            daysOfWeekHeight: 40,
            focusedDay: focusedDay,
            locale: "ko_KR",
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                this.selectedDay = selectedDay;
                this.focusedDay = focusedDay;
                print(this.selectedDay);
              });
            },
            selectedDayPredicate: (day) {
              if (selectedDay == null) return false;
              return day.year == selectedDay!.year &&
                  day.month == selectedDay!.month &&
                  day.day == selectedDay!.day;
            },
            firstDay: DateTime(2000),
            lastDay: DateTime(2100),
            headerStyle: HeaderStyle(
              headerMargin: const EdgeInsets.all(0),
              headerPadding: const EdgeInsets.all(3),
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: TextStyle(
                color: ColorManager.text,
                fontSize: 16,
              ),
              decoration: BoxDecoration(
                color: ColorManager.textfield,
              ),
            ),
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: ColorManager.calenderActive,
                shape: BoxShape.circle,
              ),
              selectedTextStyle: TextStyle(
                color: ColorManager.background,
              ),
              todayTextStyle: TextStyle(
                color: ColorManager.calenderTodaytext,
              ),
              todayDecoration: BoxDecoration(
                color: ColorManager.background,
                shape: BoxShape.circle,
                border: Border.all(
                  color: ColorManager.calenderTodaytext,
                ),
              ),
              outsideDaysVisible: false,
              defaultTextStyle: TextStyle(
                color: ColorManager.text,
              ),
              weekendTextStyle: TextStyle(
                color: ColorManager.text,
              ),
            ),
          ),
          SizedBox(
            height: 100,
            child: Obx(
              () => ListView.builder(
                itemCount: diaryController.diaryList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                        'User ID: ${diaryController.diaryList[index].userid}'),
                    subtitle: Text(
                        'Content: ${diaryController.diaryList[index].content}'),
                  );
                },
              ),
            ),
          ),
          Writedfield(),
        ],
      ),
    );
  }
}

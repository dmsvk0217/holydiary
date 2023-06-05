import 'package:flutter/material.dart';
import 'package:holydiary/model/diary.dart';
import 'package:holydiary/view/resources/color_manager.dart';
import 'package:holydiary/view/resources/font_manager.dart';
import 'package:intl/intl.dart';

class Writedfield extends StatelessWidget {
  const Writedfield({
    Key? key,
    required this.diary,
  }) : super(key: key);

  final Diary diary;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 350,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorManager.textfield,
        ),
        padding: const EdgeInsets.fromLTRB(14, 9, 14, 14),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  DateFormat('MM월 dd일').format(diary.createdTime!.toDate()),
                  style: TextStyle(
                    color: ColorManager.text,
                    fontWeight: FontWeightManager.medium,
                    fontSize: FontSize.s15,
                  ),
                ),
              ],
            ),
            Text(
              diary.content!,
              style: TextStyle(
                color: ColorManager.text,
                fontWeight: FontWeightManager.medium,
                fontSize: 12,
              ),
            ),
            Divider(
              color: ColorManager.text,
              thickness: 0.2,
              height: 20,
              indent: 20,
              endIndent: 20,
            ),
            Text(
              diary.contentGPT!,
              style: TextStyle(
                color: ColorManager.text,
                fontWeight: FontWeightManager.medium,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

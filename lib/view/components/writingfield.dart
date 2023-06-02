import 'package:flutter/material.dart';
import 'package:holydiary/view/resources/color_manager.dart';
import 'package:holydiary/view/resources/font_manager.dart';

class Writingfield extends StatelessWidget {
  const Writingfield({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorManager.textfield,
        ),
        width: 350,
        height: 220,
        padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
        child: Column(
          children: [
            Row(
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
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  height: 155,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black,
                  ),
                  padding: const EdgeInsets.all(16),
                  child: TextFormField(
                    maxLength: 300,
                    maxLines: 7,
                    style: TextStyle(
                      color: ColorManager.text,
                      fontWeight: FontWeightManager.medium,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

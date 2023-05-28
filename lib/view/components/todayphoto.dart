import 'package:flutter/material.dart';

import '../resources/color_manager.dart';
import '../resources/font_manager.dart';

class Todayphoto extends StatelessWidget {
  const Todayphoto({Key? key}) : super(key: key);

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
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "오늘의 사진",
                    style: TextStyle(
                        fontSize: FontSize.s14,
                        fontWeight: FontWeightManager.bold,
                        color: ColorManager.text),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black,
                ),
                width: 150,
                height: 150,
              )
            ],
          ),
        ),
      ),
    );
  }
}

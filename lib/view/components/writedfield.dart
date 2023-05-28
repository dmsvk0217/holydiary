import 'package:flutter/material.dart';
import 'package:holydiary/view/resources/color_manager.dart';
import 'package:holydiary/view/resources/font_manager.dart';

class Writedfield extends StatelessWidget {
  const Writedfield({Key? key}) : super(key: key);

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
                  "28 일",
                  style: TextStyle(
                    color: ColorManager.text,
                    fontWeight: FontWeightManager.medium,
                    fontSize: FontSize.s15,
                  ),
                ),
              ],
            ),
            Text(
              '하늘에 계신 우리 아버지여, 이름이 거여김을 여김을 여김을 여김을 룩히 여김을여여김을 여김을 여김을 여김을 여김을 여김을 여김을 김을 여김을 여김을 여김을 여김을 여김을 여김을 여김을 여김을 여김을 여김을 여김을 여김을 여김을 여김을 여김을 여김을  받으시오며, 나라이 임하옵시며, 뜻이 하늘에서 이룬 것 같이 땅에서도 이루어지이다. 하늘에 계신 우리 아버지여, 이름이 거룩히 여김을 받으시오며, 나라이 임하옵시며, 뜻이 하늘에서 이룬 것 같이 땅에서도 이루어지이다.',
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

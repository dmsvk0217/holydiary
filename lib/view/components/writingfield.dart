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
        padding: const EdgeInsets.all(30),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: Text(
                '영성일기',
                style: TextStyle(
                  color: ColorManager.text,
                  fontWeight: FontWeightManager.medium,
                  fontSize: 10,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black,
                ),
                padding: const EdgeInsets.all(16),
                child: Text(
                  '하늘에 계신 우리 아버지여, 이름이 거여김을 여김을 여김을 여김을 룩히 여김을여여김을 여김을 여김을 여김을 여김을 여김을 여김을 김을 여김을 여김을 여김을 여김을 여김을 여김을 여김을 여김을 여김을 여김을 여김을 여김을 여김을 여김을 여김을 여김을  받으시오며, 나라이 임하옵시며, 뜻이 하늘에서 이룬 것 같이 땅에서도 이루어지이다. 하늘에 계신 우리 아버지여, 이름이 거룩히 여김을 받으시오며, 나라이 임하옵시며, 뜻이 하늘에서 이룬 것 같이 땅에서도 이루어지이다.',
                  style: TextStyle(
                    color: ColorManager.text,
                    fontWeight: FontWeightManager.medium,
                    fontSize: 12,
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

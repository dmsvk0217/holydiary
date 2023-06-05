import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:holydiary/controller/diary_controller.dart';
import 'package:image_picker/image_picker.dart';

import '../resources/color_manager.dart';
import '../resources/font_manager.dart';

class Todayphoto extends StatefulWidget {
  const Todayphoto({Key? key}) : super(key: key);

  @override
  _TodayphotoState createState() => _TodayphotoState();
}

class _TodayphotoState extends State<Todayphoto> {
  late ImagePicker _imagePicker;
  var selectedImage;
  DiaryController diaryController = Get.put(DiaryController());

  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
  }

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
                      color: ColorManager.text,
                    ),
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
                child: IconButton(
                  icon: selectedImage != null
                      ? Image.file(selectedImage!) // 선택한 이미지를 보여줍니다.
                      : const Icon(Icons.add),
                  onPressed: () {
                    _getImage(); // 이미지 선택 함수를 호출합니다.
                  },
                  color: ColorManager.text,
                  iconSize: 70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 이미지를 선택하는 함수
  Future<void> _getImage() async {
    final pickedImage = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      setState(() {
        selectedImage = File(pickedImage.path);
        diaryController.changePickedImagePath(pickedImage.path);
      });
    }
  }
}

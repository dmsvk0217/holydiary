import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:holydiary/controller/user_controller.dart';
import 'package:holydiary/view/components/loadingdialog.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:holydiary/view/resources/color_manager.dart';
import 'package:holydiary/view/resources/font_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:holydiary/util.dart';

class Writingwithphoto extends StatelessWidget {
  Writingwithphoto({Key? key}) : super(key: key);

  UserController userController = Get.put(UserController());

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
                    "사진으로 쓰기",
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
                child: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () async {
                    await getTextIamgeFromGallery(context);
                    Get.reload();
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
}

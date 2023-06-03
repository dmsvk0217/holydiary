import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:holydiary/controller/user_controller.dart';
import 'package:holydiary/main.dart';
import 'package:holydiary/view/components/loadingdialog.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:holydiary/view/resources/color_manager.dart';
import 'package:holydiary/view/resources/font_manager.dart';
import 'package:image_picker/image_picker.dart';

class Writingwithphoto extends StatefulWidget {
  const Writingwithphoto({Key? key}) : super(key: key);

  @override
  State<Writingwithphoto> createState() => _WritingwithphotoState();
}

class _WritingwithphotoState extends State<Writingwithphoto> {
  UserController userController = Get.put(UserController());
  String parsedtext = '';

  Future _getFromGallery(BuildContext context) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    var bytes = File(pickedFile.path.toString()).readAsBytesSync();
    String img64 = base64Encode(bytes);

    var url = 'https://api.ocr.space/parse/image';
    var payload = {
      "base64Image": "data:image/jpg;base64,${img64.toString()}",
      "language": "kor"
    };
    var header = {"apikey": "$ocrapikey"};

    MyLoadingDialog.show(context);
    var post = await http.post(Uri.parse(url), body: payload, headers: header);
    var result = jsonDecode(post.body);
    MyLoadingDialog.hide(context);

    setState(() {
      parsedtext = result['ParsedResults'][0]['ParsedText'];
      userController.content.value = parsedtext;
      print(parsedtext);
    });
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
                  onPressed: () {
                    _getFromGallery(context);
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

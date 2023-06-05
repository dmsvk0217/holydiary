import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:holydiary/controller/user_controller.dart';
import 'package:holydiary/view/components/DoneWriteButton.dart';
import 'package:holydiary/view/components/writingfield.dart';
import 'package:holydiary/view/components/writingwithphoto.dart';
import '../components/todayphoto.dart';

class WritePage extends StatefulWidget {
  const WritePage({super.key});

  @override
  State<WritePage> createState() => _WritePageState();
}

final _formKey = GlobalKey<FormState>();

class _WritePageState extends State<WritePage> {
  UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => userController.focusNode.unfocus(),
        child: ListView(
          children: [
            const SizedBox(height: 30),
            // 영성일기
            Writingfield(),
            const SizedBox(height: 30),
            // 사진으로쓰기
            Writingwithphoto(),
            const SizedBox(height: 30),
            // 오늘의 사진
            const Todayphoto(),
            const SizedBox(height: 30),
            // 작성완료 버튼
            doneWriteButton(),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:holydiary/view/resources/color_manager.dart';
import 'package:holydiary/view/resources/styles_manager.dart';

class BibleReadPage extends StatelessWidget {
  BibleReadPage({super.key});

  final text = Get.arguments[0];
  final String bookname = Get.arguments[1];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(bookname),
      ),
      body: ListView(
        children: [
          Text(
            text,
            style: getMediumStyle(
              color: ColorManager.text,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}

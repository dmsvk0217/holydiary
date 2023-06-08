import 'dart:io';

import 'package:flutter/material.dart';
import 'package:accordion/accordion.dart';
import 'package:get/get.dart';
import 'package:holydiary/view/resources/bible.dart';
import 'package:holydiary/view/resources/color_manager.dart';
import 'package:holydiary/view/resources/getx_routes_manager.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path/path.dart' as path;

class BiblePage extends StatelessWidget {
  BiblePage({super.key});

  final _headerStyle = TextStyle(
    color: ColorManager.text,
    fontSize: 15,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background,
      body: Accordion(
        maxOpenSections: 3,
        headerBackgroundColorOpened: Colors.black54,
        headerPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
        children: buildBible,
      ),
    );
  }

  Future<String> reloadTextFile(String filePath) async {
    print("filePath : $filePath");
    File file = File(filePath);
    if (await file.exists()) {
      return await file.readAsString();
    } else {
      throw Exception('File does not exist');
    }
  }

//"assets/bible/Deuteronomy.txt".
  Future<String> loadAsset(String txtfileName) async {
    print("txtfileName : $txtfileName");
    String mypath = "assets/bible/aa.txt";
    print("mypath : $mypath");

    String projectPath =
        path.dirname(path.dirname(path.fromUri(Platform.script)));
    print('Project Path: $projectPath');

    try {
      String result = await reloadTextFile(mypath);
      print("result : $result");
    } catch (e) {
      print('Error: $e');
    }

    return await rootBundle.loadString(mypath).then((value) {
      print(value);
      return value;
    });
  }

  List<AccordionSection> get buildBible {
    return bibleMetaData.map(
      (map) {
        final String bookName = map['book'];
        final int chapterCount = map['chapters'];
        final String englishName = map['english_name'];

        return AccordionSection(
          headerBackgroundColor: ColorManager.background,
          headerBackgroundColorOpened: ColorManager.background,
          header: Text(bookName, style: _headerStyle),
          headerBorderRadius: 0,
          contentBackgroundColor: ColorManager.background,
          contentVerticalPadding: 0,
          contentBorderRadius: 0,
          content: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5, // Change the number of columns as desired
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            ),
            itemCount: chapterCount,
            itemBuilder: (context, chapterIndex) {
              final chapterNumber = chapterIndex + 1;
              return ElevatedButton(
                onPressed: () async {
                  print(
                      'Button pressed: $bookName Chapter $chapterNumber englishName $englishName');
                  String txtfileName = "$englishName.txt";
                  String text = await loadAsset(txtfileName);
                  Get.toNamed(Routes.bibleReadPage,
                      arguments: [text, bookName]);
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(ColorManager.background),
                ),
                child: Text(chapterNumber.toString()),
              );
            },
          ),
          contentHorizontalPadding: 20,
          contentBorderWidth: 0,
        );
      },
    ).toList();
  }
}

import 'package:flutter/material.dart';
import 'package:accordion/accordion.dart';
import 'package:holydiary/view/resources/bible.dart';
import 'package:holydiary/view/resources/color_manager.dart';
import 'dart:io';

class BiblePage extends StatelessWidget {
  BiblePage({super.key});

  final _headerStyle = TextStyle(
    color: ColorManager.text,
    fontSize: 15,
    fontWeight: FontWeight.bold,
  );
  final _contentStyleHeader = TextStyle(
    color: ColorManager.text,
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );
  final _contentStyle = TextStyle(
    color: ColorManager.text,
    fontSize: 14,
    fontWeight: FontWeight.normal,
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

  Future<String> readBibleTextFile(String bookName) async {
    try {
      // Replace 'path_to_your_text_file' with the actual path to your text file
      File file = File('../resources/$bookName');
      return await file.readAsString();
    } catch (e) {
      print('Error reading the text file: $e');
      return "Error reading the text file: $e";
    }
  }

  List<AccordionSection> get buildBible {
    return bibleMataData.map(
      (map) {
        final bookName = map['book'];
        final chapterCount = map['chapters'];
        String bibleText = '';

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
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5, // Change the number of columns as desired
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            ),
            itemCount: chapterCount,
            itemBuilder: (context, chapterIndex) {
              final chapterNumber = chapterIndex + 1;
              return ElevatedButton(
                onPressed: () async {
                  // Handle button press for the chapter
                  print('Button pressed: $bookName Chapter $chapterNumber');
                  String text = await readBibleTextFile(bookName);
                  print(text);
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        ColorManager.background)),
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

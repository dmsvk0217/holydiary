import 'package:flutter/material.dart';
import 'package:accordion/accordion.dart';
import 'package:holydiary/view/resources/bible.dart';
import 'package:holydiary/view/resources/color_manager.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

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

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  Future<String> readCounter() async {
    try {
      final file = await _localFile;

      // Read the file
      return await file.readAsString();
    } catch (e) {
      // If encountering an error, return 0
      return "encountering an error";
    }
  }

  Future<String> readBibleTextFile(String bookName) async {
    try {
      // Replace 'path_to_your_text_file' with the actual path to your text file
      File file = File('assets/bible/aa.txt');
      return await file.readAsString();
    } catch (e) {
      return "Error reading the text file: $e";
    }
  }

  Future<String> readBibleTextFile2() async {
    try {
      // Replace 'path_to_your_text_file' with the actual path to your text file
      File file = File('assets/bible/aa.txt');
      return await file.readAsString();
    } catch (e) {
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
                  // Handle button press for the chapter
                  print('Button pressed: $bookName Chapter $chapterNumber');
                  // String text = await readBibleTextFile(bookName);
                  String text = await readBibleTextFile2();
                  print(text);
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

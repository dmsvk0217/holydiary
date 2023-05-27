import 'package:flutter/material.dart';
import 'package:accordion/accordion.dart';
import 'package:holydiary/view/resources/bible.dart';
import 'package:holydiary/view/resources/color_manager.dart';

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

  List<AccordionSection> get buildBible {
    return bibleMataData
        .map(
          (map) => AccordionSection(
            headerBackgroundColor: ColorManager.background,
            headerBackgroundColorOpened: ColorManager.background,
            header: Text(map["book"], style: _headerStyle),
            content: Text(map["chapters"].toString(), style: _contentStyle),
            contentHorizontalPadding: 20,
            contentBorderWidth: 0,
          ),
        )
        .toList();
  }
}

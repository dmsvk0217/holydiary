import 'package:flutter/material.dart';

import '../components/DoneWriteButton.dart';
import '../components/writingfield.dart';

class Testcompo extends StatelessWidget {
  const Testcompo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: const [
        Writingfield(),
        SizedBox(height: 12),
        Writingfield(),
        SizedBox(height: 12),
        Writingfield(),
        SizedBox(height: 12),
        doneWriteButton(),
      ]),
    );
  }
}

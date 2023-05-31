import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          TextButton(
            onPressed: () async {},
            child: Text("translate image text"),
          ),
          Writingfield(),
          SizedBox(height: 30),
          Writingwithphoto(),
          SizedBox(height: 30),
          Todayphoto(),
          SizedBox(height: 30),
          doneWriteButton(),
        ],
      ),
    );
  }
}

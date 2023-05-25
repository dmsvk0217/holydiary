import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:holydiary/resultPage.dart';

class GetQuestion extends StatefulWidget {
  const GetQuestion({Key? key}) : super(key: key);

  @override
  _GetQuestionState createState() => _GetQuestionState();
}

class _GetQuestionState extends State<GetQuestion> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        TextField(
          controller: _controller,
        ),
        TextButton(
          onPressed: () {
            String prompt = _controller.text;
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ResultPage(prompt)));
          },
          child: const Text("Get result"),
        ),
      ]),
    );
  }
}

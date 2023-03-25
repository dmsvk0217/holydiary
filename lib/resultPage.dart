import 'package:flutter/material.dart';

import 'main.dart';

class ResultPage extends StatefulWidget {
  final String prompt;
  const ResultPage(this.prompt, {super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<String>(
        future: generateText(widget.prompt),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Text('${snapshot.data}');
          }
        },
      ),
    );
  }
}

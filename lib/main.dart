import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:holydiary/getQuestion.dart';

const apiKey = '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';
const apiUrl = 'https://api.openai.com/v1/completions';
//This is our project for mobile app develope lecture
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: GetQuestion(),
    );
  }
}

Future<String> generateText(String prompt) async {
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey'
    },
    body: jsonEncode({
      "model": "text-davinci-003",
      'prompt': prompt,
      'max_tokens': 1000,
      'temperature': 0,
      'top_p': 1,
      'frequency_penalty': 0,
      'presence_penalty': 0
    }),
  );

  Map<String, dynamic> newresponse = jsonDecode(response.body);
  return newresponse['choices'][0]['text'];
}

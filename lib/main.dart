import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:holydiary/view/resources/getx_routes_manager.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:holydiary/getQuestion.dart';

const apiKey = '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';
const apiUrl = 'https://api.openai.com/v1/completions';
//This is our project for mobile app develope lecture
void main() {
  //  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "HolyDiary",
      // theme: getApplicationTheme(),
      initialRoute: Routes.homeRoute,
      getPages: getPages,
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

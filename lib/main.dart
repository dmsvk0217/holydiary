import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:holydiary/view/resources/getx_routes_manager.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

const apiKey = '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';
const apiUrl = 'https://api.openai.com/v1/engines/davinci-codex/completions';

//This is our project for mobile app develope lecture
void main() {
  //  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "HolyDiary",
      // theme: getApplicationTheme(),
      initialRoute: Routes.getQuestionRoute,
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
      'prompt':
          "What is $prompt? Tell me like you're explaining to an eight-year-old.",
      'max_tokens': 1000,
      'temperature': 0,
      'top_p': 1,
      'frequency_penalty': 0,
      'presence_penalty': 0
    }),
  );

  Map<String, dynamic> newresponse = jsonDecode(response.body);
  final generatedText = newresponse['choices'][0]['text'];

  return generatedText;
}

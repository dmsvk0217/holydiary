import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/route_manager.dart';
import 'package:holydiary/view/resources/getx_routes_manager.dart';
import 'package:holydiary/view/resources/theme_manager.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'firebase_options.dart';
import 'package:intl/date_symbol_data_local.dart';

final openaikey = dotenv.env['openaiapiKey'];
const apiUrl = 'https://api.openai.com/v1/engines/davinci-codex/completions';

//This is our project for mobile app develope lecture
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: "lib/.env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "HolyDiary",
      theme: getApplicationTheme(),
      initialRoute: Routes.loginPage,
      getPages: getPages,
    );
  }
}

Future<String> generateText(String prompt) async {
  String generatedText = "";
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $openaikey'
    },
    body: jsonEncode({
      "model": "text-davinci-003",
      'prompt':
          "What is $prompt? Tell me like you're explaining to an eight-year-old.",
      'max_tokens': 100,
      'temperature': 0,
      'top_p': 1,
      'frequency_penalty': 0,
      'presence_penalty': 0
    }),
  );
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    generatedText = data['choices'][0]['text'];
  } else {
    generatedText = "Error: ${response.reasonPhrase}";
  }
  return generatedText;
}

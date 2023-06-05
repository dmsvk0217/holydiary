import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final openaikey = dotenv.env['openaiapiKey'];
final ocrapikey = dotenv.env['ocrapikey'];
const apiUrl = 'https://api.openai.com/v1/engines/text-davinci-003/completions';

Future<String> generateText(String prompt) async {
  String generatedText = "";

  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $openaikey'
    },
    body: jsonEncode({
      //"model": "text-davinci-003",
      'prompt':
          "What is $prompt? Tell me like you're explaining to an eight-year-old.",
      'max_tokens': 100,
      'temperature': 0,
      'top_p': 1,
      // 'frequency_penalty': 0,
      // 'presence_penalty': 0
    }),
  );
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    generatedText = data['choices'][0]['text'];
  } else {
    print(response.body);

    generatedText = "Error: ${response.body}";
  }

  return generatedText;
}

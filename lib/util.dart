import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:holydiary/controller/user_controller.dart';
import 'package:holydiary/view/components/loadingdialog.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:image_picker/image_picker.dart';

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

Future<void> getTextIamgeFromGallery(BuildContext context) async {
  UserController userController = Get.put(UserController());

  String parsedtext = '';
  final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
  if (pickedFile == null) return;

  var bytes = File(pickedFile.path.toString()).readAsBytesSync();
  String img64 = base64Encode(bytes);

  var url = 'https://api.ocr.space/parse/image';
  var payload = {
    "base64Image": "data:image/jpg;base64,${img64.toString()}",
    "language": "kor"
  };
  var header = {"apikey": "$ocrapikey"};

  MyLoadingDialog.show(context);
  var post = await http.post(Uri.parse(url), body: payload, headers: header);
  var result = jsonDecode(post.body);
  MyLoadingDialog.hide(context);

  parsedtext = result['ParsedResults'][0]['ParsedText'];
  userController.textController.text = parsedtext;
  print("parsedtext");
  print(parsedtext);
}

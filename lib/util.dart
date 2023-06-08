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
const apiUrl = 'https://api.openai.com/v1/engines/text-davinci-003/completions';

final ocrapikey = dotenv.env['ocrapikey'];

final naverId = dotenv.env['naverId'];
final naverSecret = dotenv.env['naverSecret'];

Future<String> getAnswer(String prompt) async {
  String translatedPrompt = await getTranslationPapago(prompt, 1);
  print("--------------translatedPrompt--------------");
  print(translatedPrompt);
  String gptAnswer = await generateText(translatedPrompt);
  print("--------------gptAnswer--------------");
  print(gptAnswer);
  String translatedGPTAnswer = await getTranslationPapago(gptAnswer, 2);
  print("--------------translatedGPTAnswer--------------");
  print(translatedGPTAnswer);
  return translatedGPTAnswer;
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
      //"model": "text-davinci-003",
      'prompt':
          "What is $prompt? Tell me like you're explaining to an eight-year-old.",
      'max_tokens': 1000,
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

///papago api
Future<String> getTranslationPapago(String prompt, int option) async {
  String clientId = '$naverId';
  String clientSecret = '$naverSecret';
  String contentType = "application/x-www-form-urlencoded; charset=UTF-8";
  String url = "https://openapi.naver.com/v1/papago/n2mt";

  http.Response trans = await http.post(
    Uri.parse(url),
    headers: {
      'Content-Type': contentType,
      'X-Naver-Client-Id': clientId,
      'X-Naver-Client-Secret': clientSecret,
      'Access-Control-Allow-Origin': '*', // CORS 허용
    },
    body: {
      'source': option == 1 ? "ko" : "en", //위에서 언어 판별 함수에서 사용한 language 변수
      'target': option == 1 ? "en" : "ko", //원하는 언어를 선택할 수 있다.
      'text': prompt,
    },
  );
  if (trans.statusCode == 200) {
    var dataJson = jsonDecode(trans.body);
    var resultPapago = dataJson['message']['result']['translatedText'];
    print(resultPapago);
    return resultPapago;
  } else {
    print(trans.statusCode);
    return "fail to get papago result. trans.statusCode : ${trans.statusCode}";
  }
}

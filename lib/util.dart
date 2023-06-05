import 'package:flutter_dotenv/flutter_dotenv.dart';

final openaikey = dotenv.env['openaiapiKey'];
final ocrapikey = dotenv.env['ocrapikey'];
const apiUrl = 'https://api.openai.com/v1/engines/text-davinci-003/completions';

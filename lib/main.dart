import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:holydiary/app.dart';
import 'firebase_options.dart';
import 'package:intl/date_symbol_data_local.dart';

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

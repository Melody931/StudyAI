import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'screens/home_screen.dart';


Future<void> main() async {

  // Permite usar código async antes de iniciar Flutter.
  WidgetsFlutterBinding.ensureInitialized();


  // Carga las variables del archivo .env.
  await dotenv.load();


  runApp(
    const StudyAIApp(),
  );
}


class StudyAIApp extends StatelessWidget {

  const StudyAIApp({super.key});


  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      title: 'StudyAI',

      debugShowCheckedModeBanner: false,

      home: const HomeScreen(),

    );

  }
}
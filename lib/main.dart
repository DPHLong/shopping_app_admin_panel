import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:multi_web_admin/constants/api_key.dart';
import 'package:multi_web_admin/views/screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: (kIsWeb || Platform.isAndroid)
          ? FirebaseOptions(
              apiKey: FirebaseConfig.apiKey,
              appId: FirebaseConfig.appId,
              messagingSenderId: FirebaseConfig.messagingSenderId,
              projectId: FirebaseConfig.projectId,
              storageBucket: FirebaseConfig.storageBucket,
            )
          : null,
    );
  } catch (e) {
    debugPrint('--- Failed to initialize Firebase: $e ---');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MainScreen(),
      builder: EasyLoading.init(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:firedart/firedart.dart';
import 'package:rider_firebase_oak/constant/key_const.dart';
import 'package:rider_firebase_oak/presentation/pages/start_page.dart';

export 'package:flutter/material.dart' hide Page;
export 'package:firedart/firedart.dart';
export 'package:rider_firebase_oak/constant/key_const.dart';
export 'package:rider_firebase_oak/presentation/pages/start_page.dart';

void main() {
  // const apiKey = "AIzaSyA6Re7qSlSePRJ3OgRZG-Nni6Rvdb1vFuQ";
  Firestore.initialize(projectId);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: StartPage(),
    );
  }
}

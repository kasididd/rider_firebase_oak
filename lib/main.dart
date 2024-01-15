import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rider_firebase_oak/constant/key_const.dart';
import 'package:rider_firebase_oak/firebase_options.dart';
import 'package:rider_firebase_oak/presentation/pages/start_page.dart';

export 'package:firedart/firedart.dart';
export 'package:flutter/material.dart' hide Page;
export 'package:rider_firebase_oak/constant/key_const.dart';
export 'package:rider_firebase_oak/presentation/pages/start_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (defaultTargetPlatform != TargetPlatform.windows) {
    // window currently don't support storage emulator
    final emulatorHost = (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) ? '10.0.2.2' : 'localhost';
    Firestore.initialize(projectId);
    await FirebaseStorage.instance.useStorageEmulator(emulatorHost, 9199);
  }

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

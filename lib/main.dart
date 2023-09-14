import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
        // options: const FirebaseOptions(
        //   apiKey: "",
        //   appId: "",
        //   messagingSenderId: "",
        //   projectId: "",
        // ),
        );
  } else {
    Firebase.app(); // if already initialized, use that one
  }

  runApp(const ProviderScope(child: MyApp()));
}

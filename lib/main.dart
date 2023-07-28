import 'package:api/Pages/DeadScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Pages/LoginScreen.dart';
import 'Pages/RegisterScreen.dart';
import 'Pages/TamagotchiScreen.dart';
import 'Pages/Wrapper.dart';


import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        initialRoute: '/Register',
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/Tamagotchi': (context) => TamagotchiScreen(),
          // When navigating to the "/second" route, build the SecondScreen widget.
          '/DeadScreen': (context) => const DeadScreen(),
          '/Login': (context) => LoginScreen(),
          '/Register': (context) => RegisterScreen(),
        },
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      );
  }
}

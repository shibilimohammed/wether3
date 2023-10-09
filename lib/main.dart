import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wether/themechange.dart';

import 'api.dart';
import 'homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SProvider(),),
          ChangeNotifierProvider(create: (context) => DarkThemePreference()), 
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}

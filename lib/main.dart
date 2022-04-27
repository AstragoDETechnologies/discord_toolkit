import 'package:flutter/material.dart';

import 'src/home_page/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Discord Toolkit',
      theme: ThemeData(
        colorScheme: ColorScheme.light().copyWith(
          primary: Colors.indigo,
          secondary: Colors.indigoAccent,
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.dark().copyWith(
          primary: Colors.indigo,
          secondary: Colors.indigoAccent,
        ),
        scaffoldBackgroundColor: Colors.black,
      ),
      themeMode: ThemeMode.system,
      routes: {
        HomePage.routeName: (context) => HomePage(),
      },
      initialRoute: HomePage.routeName,
    );
  }
}

import 'package:flutter/material.dart';

import 'src/home_page/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Discord Toolkit Beta',
        theme: ThemeData(
          colorScheme: ColorScheme.light().copyWith(
            primary: Colors.indigo,
            secondary: Colors.grey[800],
          ),
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.dark().copyWith(
            primary: Colors.indigo,
            secondary: Colors.grey[300],
          ),
          scaffoldBackgroundColor: Colors.black,
        ),
        themeMode: ThemeMode.system,
        // Always use 24h format
        builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true), child: child!),
        routes: {
          HomePage.routeName: (context) => HomePage(),
        },
        initialRoute: HomePage.routeName,
      );
    });
  }
}

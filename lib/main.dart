import 'package:expense_tracking/expences.dart';
import 'package:flutter/material.dart';


var gColorScheme = ColorScheme.fromSeed(seedColor: Colors.blue);
var gDarkColorScheme =
ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 6, 89, 23));

void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: gDarkColorScheme,
        // useMaterial3:  true,

        cardTheme: CardTheme(
          color: gColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),
      theme: ThemeData().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 160, 224, 210),
        colorScheme: gColorScheme,
        appBarTheme: AppBarTheme(
          backgroundColor: gColorScheme.onPrimaryContainer,
          foregroundColor: gColorScheme.onPrimary,
        ),
        cardTheme: CardTheme(
          color: gColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: gColorScheme.primaryContainer,
              elevation: 12,
              shadowColor: gColorScheme.inversePrimary,
            )),
        textTheme: ThemeData().textTheme.copyWith(
            titleLarge: TextStyle(
              color: gColorScheme.onSecondaryContainer,
              fontWeight: FontWeight.bold,
            )),
      ),
      home: const Expenses(),
    );
  }
}

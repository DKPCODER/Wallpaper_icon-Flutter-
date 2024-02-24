import 'package:flutter/material.dart';
import 'package:wallpaper_icon/views/screens/homescreens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}); 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WALLPAPER_ICON',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple), 
        useMaterial3: true,
      ),
      home: const Homescreen(title:'WALLPAPER_ICON'),
    );
  }
}

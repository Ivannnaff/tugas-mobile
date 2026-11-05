import 'package:flutter/material.dart';
import 'screens/form_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Pendaftaran Kegiatan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6C3CE1)),
        scaffoldBackgroundColor: const Color(0xFFF6F3FF),
      ),
      home: const FormScreen(),
    );
  }
}

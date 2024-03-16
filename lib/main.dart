import 'package:flutter/material.dart';
import 'package:generador_contra/views/page/passwordGenerator.dart';



void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.red[100],
        appBar: AppBar(
          title: const Text(
            'GENERADOR DE CONTRASEÑAS',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black,
                fontSize: 30.0,
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.red[600],
        ),
        body: const Center(
          child: PasswordGenerator(),
        ),
      ),
    );
  }
}
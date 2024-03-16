import 'dart:math';

import 'package:flutter/material.dart';

import '../../models/Password.dart';
import '../widgets/OptionsView.dart';
import '../widgets/PasswordView.dart';

class PasswordGenerator extends StatefulWidget {
  const PasswordGenerator({super.key});

  @override
  State<PasswordGenerator> createState() => _PasswordGeneratorState();
}

class _PasswordGeneratorState extends State<PasswordGenerator> {
  late double width;
  late String currentPassword;
  Password passwordOptions = Password(
    length: 8,
    uppercase: true,
    lowercase: true,
    numbers: true,
    symbols: true,
    minLength: 4,
  );

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    setState(() {
      currentPassword = _generatePassword();
    });
    return Container(
      width: width * 0.8,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(5),
      child: Column(children: [
        PasswordView(
            currentPassword: currentPassword,
            onRefresh: () {
              setState(() {
                currentPassword = _generatePassword();
              });
            }),
        const SizedBox(height: 20),
        FormOptions(
            passwordOptions: passwordOptions, onOptionsChanged: _updateOptions),
      ]),
    );
  }

  _updateOptions(Password newOptions) {
    setState(() {
      if (!newOptions.uppercase &&
          !newOptions.lowercase &&
          !newOptions.numbers &&
          !newOptions.symbols) {
        newOptions.uppercase = true;
      }

      _generatePassword();
    });
  }

  _generatePassword() {
    int counter = 0;
    String password = '';
    String characters = '';
    if (passwordOptions.uppercase) {
      String upper = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
      characters += upper;
      counter++;
      password += upper[Random().nextInt(upper.length)];
    }
    if (passwordOptions.lowercase) {
      String lower = 'abcdefghijklmnopqrstuvwxyz';
      characters += lower;
      password += lower[Random().nextInt(lower.length)];
      counter++;
    }
    if (passwordOptions.numbers) {
      String numbers = '0123456789';
      characters += numbers;
      password += numbers[Random().nextInt(numbers.length)];
      counter++;
    }
    if (passwordOptions.symbols) {
      String symbols = '!@#%^&*()_+';
      characters += symbols;
      password += symbols[Random().nextInt(symbols.length)];
      counter++;
    }
    passwordOptions.minLength = counter;
    if (passwordOptions.length < passwordOptions.minLength) {
      passwordOptions.length = passwordOptions.minLength;
    }
    for (int i = 0; i < passwordOptions.length - counter; i++) {
      password += characters[Random().nextInt(characters.length)];
    }
    return password;
  }
}
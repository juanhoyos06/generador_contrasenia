import 'package:flutter/material.dart';

class PasswordView extends StatelessWidget {
  late double width;
  String currentPassword;
  final Function onRefresh;
  PasswordView(
      {super.key, required this.currentPassword, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return _passwordView();
  }

  Widget _passwordView() {
    return Container(
      width: width * 0.8,
      height: 80,
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(currentPassword,
                  style: const TextStyle(fontSize: 15, color: Colors.black),
                  textAlign: TextAlign.left),
            ),
            _buttonGroup()
          ]),
    );
  }

  Widget _buttonGroup() {
    return Row(
      children: [
        const IconButton(onPressed: null, icon: Icon(Icons.copy)),
        IconButton(
            icon: const Icon(Icons.refresh), onPressed: () => onRefresh())
      ],
    );
  }
}

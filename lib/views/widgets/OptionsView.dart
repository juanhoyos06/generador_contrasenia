import 'package:flutter/material.dart';

import '../../models/Password.dart';


enum RadioValue { all, simple }

class FormOptions extends StatefulWidget {
  final Password passwordOptions;
  Function(Password) onOptionsChanged;
  FormOptions(
      {super.key,
      required this.passwordOptions,
      required this.onOptionsChanged});

  @override
  State<FormOptions> createState() => _FormOptionsState();
}

class _FormOptionsState extends State<FormOptions> {
  int maxLength = 17;
  late int minLenght;
  late double width;
  late int length;
  late TextEditingController _lengthController;
  RadioValue _radioValue = RadioValue.all;
  @override
  Widget build(BuildContext context) {
    minLenght = widget.passwordOptions.minLength;
    width = MediaQuery.of(context).size.width;
    length = widget.passwordOptions.length;
    _lengthController = TextEditingController(text: length.toString());
    return _formOptions();
  }

  Widget _formOptions() {
    return Container(
      width: width * 0.8,
      height: 400,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 5,
            )
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _formTitle(),
          _formLengthOption(),
          const SizedBox(
            height: 20,
          ),
          _radialButtonsGroup(),
          const SizedBox(
            height: 20,
          ),
          _passwordOptionsBoxGroup()
        ],
      ),
    );
  }

  Widget _formTitle() {
    return Container(
      width: width * 0.8,
      padding: const EdgeInsets.all(10),
      child: const Column(
        children: [
          Text(
            "PERSONALIZAR CONTRASEÑA",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          Divider(
            color: Colors.black,
            thickness: 4,
          ),
        ],
      ),
    );
  }

  Widget _formLengthOption() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: width * 0.1,
            child: _lengthInput(),
          ),
          SizedBox(width: width * 0.5, child: _slider())
        ]);
  }

  Widget _lengthInput() {
    return TextFormField(
      controller: _lengthController,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      onEditingComplete: () {
        if (_lengthController.text.isEmpty) return;

        setState(() {
          if (int.parse(_lengthController.text) < minLenght) {
            _lengthController.text = minLenght.toString();
          }

          if (int.parse(_lengthController.text) > maxLength) {
            _lengthController.text = maxLength.toString();
          }

          // default value (8 characters
          length = int.parse(_lengthController.text);
          widget.passwordOptions.length = length;
          widget.onOptionsChanged(widget.passwordOptions);
        });
      },
    );
  }

  _slider() {
    return Slider(
      min: minLenght.toDouble(),
      max: maxLength.toDouble(),
      value: length.toDouble(),
      activeColor: Colors.red.shade800,
      onChanged: (value) {
        setState(() {
          length = value.toInt();
          widget.passwordOptions.length = length;
          _lengthController.text = length.toString();
          widget.onOptionsChanged(widget.passwordOptions);
        });
      },
    );
  }

  _radialButtonsGroup() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            const Text('all'),
            Radio(
              value: RadioValue.all,
              groupValue: _radioValue,
              onChanged: (value) {
                setState(() {
                  _radioValue = value!;
                });
              },
            ),
          ],
        ),
        Column(
          children: [
            const Text('simple'),
            Radio(
              value: RadioValue.simple,
              groupValue: _radioValue,
              onChanged: (value) {
                setState(() {
                  _radioValue = value!;
                  widget.passwordOptions.numbers = false;
                  widget.passwordOptions.symbols = false;
                  widget.onOptionsChanged(widget.passwordOptions);
                });
              },
            ),
          ],
        )
      ],
    );
  }

  _passwordOptionsBoxGroup() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _checkBoxOption(widget.passwordOptions.uppercase, (value) {
                widget.passwordOptions.uppercase = value;
                widget.onOptionsChanged(widget.passwordOptions);
              }, 'Mayúsculas'),
              _checkBoxOption(widget.passwordOptions.lowercase, (value) {
                widget.passwordOptions.lowercase = value;
                widget.onOptionsChanged(widget.passwordOptions);
              }, 'Minúsculas'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _checkBoxOption(widget.passwordOptions.symbols,
                  _isDisabled((value) {
                widget.passwordOptions.symbols = value;
                widget.onOptionsChanged(widget.passwordOptions);
              }), 'Simbolos'),
              _checkBoxOption(widget.passwordOptions.numbers,
                  _isDisabled((value) {
                widget.passwordOptions.numbers = value;
                widget.onOptionsChanged(widget.passwordOptions);
              }), 'Números'),
            ],
          )
        ]);
  }

  _checkBoxOption(bool value, Function? onChangedFunction, String name) {
    return Column(
      children: [
        Text(name),
        Checkbox(
          value: value,
          onChanged: onChangedFunction == null
              ? null
              : (value) => onChangedFunction(value),
        ),
      ],
    );
  }

  _isDisabled(Function function) {
    if (_radioValue == RadioValue.simple) {
      return null;
    }
    return function;
  }
}
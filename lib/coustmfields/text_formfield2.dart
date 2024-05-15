import 'package:flutter/material.dart';
import 'package:hotelonwer/coustmfields/theame.dart';

class CustomTextField2 extends StatefulWidget {
  final String hintText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final bool isPassword;
  final int? minLength;
  final int? maxLines;
  final String? Function(String?)? validator;
  final Color? fillColor;

  const CustomTextField2({
    required this.keyboardType,
    required this.controller,
    required this.hintText,
    this.isPassword = false,
    this.minLength,
    this.maxLines,
    this.validator,
    this.fillColor,
    Key? key,
  }) : super(key: key);

  @override
  _CustomTextField2State createState() => _CustomTextField2State();
}

class _CustomTextField2State extends State<CustomTextField2> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color.fromARGB(0, 255, 255, 255),
      borderRadius: BorderRadius.circular(15),
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        obscureText: widget.isPassword,
        maxLines: widget.maxLines,
        validator: (value) {
          if (widget.validator != null) {
            final error = widget.validator!(value);
            if (error != null) {
              return error;
            }
          }
          return null;
        },
        style: const TextStyle(
          color: Color.fromARGB(255, 0, 0, 0),
        ),
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
          ),
          filled: true,
          fillColor: widget.fillColor ?? const Color.fromARGB(0, 136, 136, 136),
          border: OutlineInputBorder(borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: mycolor3),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
        ),
      ),
    );
  }
}

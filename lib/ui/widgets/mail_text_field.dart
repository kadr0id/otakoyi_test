
import 'package:flutter/material.dart';
import 'package:otakoyi_test/thema.dart';

Widget input({
  TextEditingController controller,
  Function(String) changeCallback,
  String hint,
  bool obscure = false,
  TextInputType type = TextInputType.emailAddress,
  FocusNode node
}) => Padding(
  padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
  child: Container(
    height: 48.0,
   // decoration: shadowCard(color: purple.withOpacity(0.5), radius: 12.0),
    alignment: Alignment(0.5, 0.5),
    child: Padding(
      padding: EdgeInsets.only(left: 16.0),
      child: TextField(
        obscureText: obscure,
        keyboardType: type,
        onChanged: changeCallback,
        controller: controller,
        focusNode: node,

        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: gold)),
          errorBorder: OutlineInputBorder(borderSide: BorderSide(color: error)),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: medium_gray )),
          suffixIcon: Icon(Icons.email, color: dark_blue),

          hintText: hint,
          helperText: 'Input email',
          helperStyle: helper,
          border: InputBorder.none,
        ),
      ),
    ),
  ),
);
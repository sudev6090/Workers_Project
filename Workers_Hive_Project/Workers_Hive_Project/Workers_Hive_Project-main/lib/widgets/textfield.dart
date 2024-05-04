// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class TextFieldd extends StatelessWidget {
  final TextEditingController controller;
  final String name;
  final IconData icons;
  final String validtext;
   int? max;
  final TextInputType? typeK;

   TextFieldd({
    super.key,
    this.max,
    this.typeK,
    required this.controller,
    required this.name,
    required this.icons,
    required this.validtext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: TextFormField(
        maxLength:max ,
       
        validator: (value) {
          if (value == null || value.isEmpty) {
            return validtext;
          } else {
            return null;
          }
        },
        controller: controller,
        keyboardType:typeK,
        decoration: InputDecoration(
          labelText: name,
          border: const OutlineInputBorder(),
          prefixIcon: Icon(icons),
        ),
      ),
    );
  }
}

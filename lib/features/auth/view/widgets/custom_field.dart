import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;

  const CustomField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.obscureText,

    });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: (val){
        if(val!.isEmpty){
          return "$hintText is missing!";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: hintText,
      ),
      
    );
  }
}
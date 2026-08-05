import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final bool readOnly;
  final VoidCallback? onTap;

  const CustomField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.obscureText,
    this.readOnly = false,
    this.onTap,

    });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      readOnly: readOnly,
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
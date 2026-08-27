import 'package:flutter/material.dart';

class CustomtextfieldWidget extends StatelessWidget {
  final TextEditingController emailcontroller;
  final bool obscureText;
  final String labelText;
  final IconData icon;
  final bool showPasswordIcon;
  final VoidCallback? onPressed;
  const CustomtextfieldWidget({super.key, required this.emailcontroller, 
  this.obscureText = false, required this.labelText, required this.icon, 
  this.showPasswordIcon = false, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: emailcontroller,
      obscureText: obscureText,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        label: Text(labelText),
        prefixIcon: Icon(icon),
        suffixIcon: showPasswordIcon
        ? IconButton(
          onPressed: onPressed,
          icon: Icon(
            obscureText
            ? Icons.visibility_off
            : Icons.visibility,
          )
        )
        : null ,

      ),
    );

  }
}
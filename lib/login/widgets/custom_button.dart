import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool loading;
  final String text;
  const CustomButton({super.key, required this.onPressed, required this.loading, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: loading ? null : onPressed, 
        child: loading
        ? CircularProgressIndicator(
          color: Colors.blue,
        )
        : Text(text, style: TextStyle(fontSize: 20),),
      ),
    );
  }
}

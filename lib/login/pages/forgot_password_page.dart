import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/login/widgets/custom_button.dart';
import 'package:flutter_application_2/login/widgets/customtextfield_widget.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailcontroller = TextEditingController();
  bool loading = false;

  Future forgotpassword() async {
    setState(() {
      loading = true;
    });

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailcontroller.text.trim(),
      );
      if(!mounted) return;
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Password reset email sent successfully")));
      Navigator.pop(context);
    } on FirebaseAuthException catch(e) {
      if(!mounted) return;
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message ?? "Something went wrong")));
    }
  }

  @override
  void dispose() {
    emailcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            CustomtextfieldWidget(
              emailcontroller: emailcontroller, 
              labelText: "Enter your email", 
              icon: Icons.mail,
            ),
            SizedBox(height: 20,),
            CustomButton(
              onPressed: forgotpassword, 
              loading: loading, 
              text: "Reset Password"
            )
          ],
          
        ),
      ),

    );
  }
}
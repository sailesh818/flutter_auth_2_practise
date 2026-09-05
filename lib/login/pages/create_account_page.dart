import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/home/pages/main_navigationbar_page.dart';
import 'package:flutter_application_2/login/widgets/custom_button.dart';
import 'package:flutter_application_2/login/widgets/customtextfield_widget.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmpassword = TextEditingController();
  bool hidePassword = true;
  bool hideConfirmPassword = true;
  bool loading = false;

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> createAccount() async {
  if (password.text != confirmpassword.text) {
    showMessage("Passwords do not match");
    return;
  }

  try {
    setState(() {
      loading = true;
    });

    await auth.createUserWithEmailAndPassword(
      email: email.text.trim(),
      password: password.text.trim(),
    );

    if (!mounted) return;

    showMessage("Account created successfully");

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainNavigationbarPage()
      ),
    );
  } on FirebaseAuthException catch (e) {
    String error = "Something went wrong";

    if (e.code == "email-already-in-use") {
      error = "Email already registered";
    } else if (e.code == "weak-password") {
      error = "Password is too weak";
    } else if (e.code == "invalid-email") {
      error = "Please enter a valid email";
    }

    if (mounted) {
      showMessage(error);
    }
  } finally {
    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }
}

  void showMessage(String message){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Account Page"),),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CustomtextfieldWidget(
              emailcontroller: email, 
              labelText: 'Enter your email', 
              icon: Icons.email,
            ),
            SizedBox(height: 15,),
            CustomtextfieldWidget(
              emailcontroller: password, 
              labelText: "Enter your Password", 
              icon: Icons.lock,
              obscureText: hidePassword,
              showPasswordIcon: true,
              onPressed: () {
                setState(() {
                  hidePassword = !hidePassword;
                });
              },
            ),
            SizedBox(height: 15,),
            CustomtextfieldWidget(
              emailcontroller: confirmpassword, 
              labelText: "Confirm your Password", 
              icon: Icons.lock,
              obscureText: hideConfirmPassword,
              showPasswordIcon: true,
              onPressed: () {
                setState(() {
                  hideConfirmPassword = !hideConfirmPassword;
                });
              },
            ),
            SizedBox(height: 15,),
            CustomButton(
              onPressed: createAccount,
              loading: loading, 
              text: 'Create Account',

            )
            
          ],
        ),
      )

    );
  }
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/home/pages/home_page.dart';
import 'package:flutter_application_2/login/pages/create_account_page.dart';
import 'package:flutter_application_2/login/pages/forgot_password_page.dart';
import 'package:flutter_application_2/login/widgets/custom_button.dart';
import 'package:flutter_application_2/login/widgets/customtextfield_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  bool loading = false;
  bool hidePassword = true;

  Future login() async {
    setState(() {
      loading = true;
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailcontroller.text.trim(), 
        password: passwordcontroller.text.trim()
      );
      if(!mounted) return;
      setState(() {
        loading = false;
      });
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));

    } on FirebaseAuthException catch(e) {
      if(!mounted) return;
      setState(() {
        loading = false;
      });


      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message ?? "Login Failed")));
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            CustomtextfieldWidget(
              emailcontroller: emailcontroller,
              labelText: "Enter your email", 
              icon: Icons.mail
            ),
            SizedBox(height: 20,),
            CustomtextfieldWidget(
              emailcontroller: passwordcontroller, 
              labelText: "Enter your password", 
              icon: Icons.lock,
              obscureText: hidePassword,
              showPasswordIcon: true,
              onPressed: () {
                setState(() {
                  hidePassword = !hidePassword;
                });
              },
            ),
            SizedBox(height: 20,),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordPage()));
                },
                child: Text("Forgot Password ?")),
            ),
            SizedBox(height: 20,),
            CustomButton(
              onPressed: login, 
              loading: loading, 
              text: "Login"
            ),
            SizedBox(height: 20,),
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Are you new?  "),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CreateAccountPage()));
                    },
                    child: Text("Create Account", style: TextStyle(color: Colors.blue),)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
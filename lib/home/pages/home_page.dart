import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/login/pages/create_account_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            InkWell(
              onTap: () async{
                await FirebaseAuth.instance.signOut();

                if(context.mounted) {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CreateAccountPage()));
                }
              },
              child: Text("logout", 
            style: TextStyle(fontSize: 20, 
            color: const Color.fromARGB(255, 24, 0, 175)),))
          ],
        ),
      ),
    );
  }
}
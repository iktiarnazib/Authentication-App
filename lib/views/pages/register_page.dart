import 'package:authapp/app/mobile/auth_service.dart';
import 'package:authapp/data/constants.dart';
import 'package:authapp/data/notifiers.dart';
import 'package:authapp/views/pages/home_page.dart';
import 'package:authapp/views/widget_tree.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String errorMessage = "";
  TextEditingController rcontrollerEmail = TextEditingController();
  TextEditingController rcontrollerPass = TextEditingController();
  void register() async {
    try {
      await authService.value.createAccount(
        email: rcontrollerEmail.text.trim(),
        password: rcontrollerPass.text.trim(),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return HomePage();
          },
        ),
      );
      selectedPageNotifier.value = 0;
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message ?? "There is an error";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Register your account",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset("assets/lotties/register.json", repeat: false),
              Text(
                "Register",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: rcontrollerEmail,
                decoration: InputDecoration(
                  hintText: "Email",
                  hintStyle: TextStyle(color: Colors.white30),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: rcontrollerPass,
                decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: TextStyle(color: Colors.white30),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),

              Text(errorMessage, style: TextStyle(color: Colors.red)),
              FilledButton(
                onPressed: () {
                  register();
                },
                style: FilledButton.styleFrom(
                  minimumSize: Size(double.infinity, 40.0),
                ),
                child: Text("Register"),
              ),

              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return WidgetTree();
                      },
                    ),
                  );
                },
                child: Text("Already have an account? Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

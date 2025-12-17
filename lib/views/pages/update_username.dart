import 'package:authapp/app/mobile/auth_service.dart';
import 'package:authapp/data/constants.dart';
import 'package:authapp/views/pages/profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class UpdateUsername extends StatefulWidget {
  const UpdateUsername({super.key});

  @override
  State<UpdateUsername> createState() => _UpdateUsernameState();
}

class _UpdateUsernameState extends State<UpdateUsername> {
  TextEditingController controllerUsername = TextEditingController();
  String errorMessage = '';
  void updateUser() async {
    try {
      await authService.value.updateUsername(username: controllerUsername.text);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('username updated!'),
            content: Text('Your username has been updated!'),
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message ?? 'There was an error';
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Lottie.asset("assets/lotties/Username.json", repeat: false),
              Text(
                "Change Username",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: controllerUsername,
                decoration: InputDecoration(
                  hintText: "Username",
                  hintStyle: TextStyle(color: Colors.white30),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              Text(errorMessage, style: TextStyle(color: Colors.red)),
              FilledButton(
                onPressed: () {
                  updateUser();
                },
                style: FilledButton.styleFrom(
                  minimumSize: Size(double.infinity, 40.0),
                ),
                child: Text("Change Username"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

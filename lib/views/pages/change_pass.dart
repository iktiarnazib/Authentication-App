import 'package:authapp/app/mobile/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ChangePass extends StatefulWidget {
  const ChangePass({super.key});

  @override
  State<ChangePass> createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerOldPass = TextEditingController();
  TextEditingController controllerNewPass = TextEditingController();

  String errorMessage = '';

  void changePassword() async {
    try {
      await authService.value.resetPasswordFromCurrentPassword(
        currentPassword: controllerOldPass.text,
        newPassword: controllerNewPass.text,
        email: controllerEmail.text,
      );
      errorMessage = '';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.teal,
          behavior: SnackBarBehavior.floating,
          content: Text(
            'Password has been updated!',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message ?? 'There was an error';
      });
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Change Password',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/lotties/ChangePassword.json', height: 300.0),
            SizedBox(height: 30.0),
            Text(
              'Change your Password',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            TextField(
              controller: controllerEmail,
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
              controller: controllerOldPass,
              decoration: InputDecoration(
                hintText: "Old Password",
                hintStyle: TextStyle(color: Colors.white30),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: controllerNewPass,
              decoration: InputDecoration(
                hintText: "New Password",
                hintStyle: TextStyle(color: Colors.white30),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            Text(errorMessage, style: TextStyle(color: Colors.red)),
            FilledButton(
              onPressed: () {
                changePassword();
              },
              style: FilledButton.styleFrom(
                minimumSize: Size(double.infinity, 40.0),
              ),
              child: Text("Change Password"),
            ),
          ],
        ),
      ),
    );
  }
}

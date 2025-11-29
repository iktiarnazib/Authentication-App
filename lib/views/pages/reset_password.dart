import 'package:authapp/views/pages/home_page.dart';
import 'package:authapp/views/widget_tree.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerCurrentPass = TextEditingController();
  TextEditingController controllernewPass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Password reset page",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Reset Password",
              style: TextStyle(
                color: Colors.white,
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
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
              controller: controllerCurrentPass,
              decoration: InputDecoration(
                hintText: "Current Password",
                hintStyle: TextStyle(color: Colors.white30),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: controllernewPass,
              decoration: InputDecoration(
                hintText: "New Password",
                hintStyle: TextStyle(color: Colors.white30),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            FilledButton(
              onPressed: () {},

              style: FilledButton.styleFrom(
                minimumSize: Size(double.infinity, 40.0),
              ),
              child: Text("Reset Password"),
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
              child: Text("Go back to login page"),
            ),
          ],
        ),
      ),
    );
  }
}

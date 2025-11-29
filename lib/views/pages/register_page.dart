import 'package:authapp/views/pages/home_page.dart';
import 'package:authapp/views/widget_tree.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Register your account",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
              controller: controller2,
              decoration: InputDecoration(
                hintText: "Iktiarnazib@gmail.com",
                hintStyle: TextStyle(color: Colors.white30),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: controller3,
              decoration: InputDecoration(
                hintText: "Password",
                hintStyle: TextStyle(color: Colors.white30),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            FilledButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return HomePage();
                    },
                  ),
                );
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
    );
  }
}

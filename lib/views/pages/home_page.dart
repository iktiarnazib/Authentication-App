import 'package:authapp/views/widget_tree.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Inside the app",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Text("Authenticated", style: TextStyle(fontSize: 20.0)),
            SizedBox(height: 5.0),
            OutlinedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return WidgetTree();
                    },
                  ),
                );
              },
              child: Text("Log out"),
            ),
          ],
        ),
      ),
    );
  }
}

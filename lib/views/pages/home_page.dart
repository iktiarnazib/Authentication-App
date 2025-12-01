import 'package:authapp/app/mobile/auth_service.dart';
import 'package:authapp/data/notifiers.dart';
import 'package:authapp/views/pages/profile_page.dart';
import 'package:authapp/views/widget_tree.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedPage = 0;
  String errorMessage = '';
  final user = authService.value.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Inside the app",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Row(
            children: [
              Text('Welcome:'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: Colors.teal,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(user?.email ?? "No user"),
                  ),
                ),
              ),
            ],
          ),
        ],
        centerTitle: false,
        automaticallyImplyLeading: false,
      ),
      body: ValueListenableBuilder(
        valueListenable: selectedPageNotifier,
        builder: (BuildContext context, dynamic selectedPage, Widget? child) {
          return selectedPage == 0
              ? Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Lottie.asset("assets/lotties/Home.json", height: 400.0),
                        Text("Authenticated", style: TextStyle(fontSize: 40.0)),
                        Text(
                          "Home page is under development",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5.0),
                      ],
                    ),
                  ),
                )
              : ProfilePage();
        },
      ),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: selectedPageNotifier,
        builder: (BuildContext context, dynamic selectedPage, Widget? child) {
          return NavigationBar(
            destinations: [
              NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
              NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
            ],
            onDestinationSelected: (int value) {
              setState(() {
                selectedPageNotifier.value = value;
              });
            },
            selectedIndex: selectedPage,
          );
        },
      ),
    );
  }
}

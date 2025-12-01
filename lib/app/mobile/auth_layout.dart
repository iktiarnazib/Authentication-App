import 'package:authapp/views/pages/home_page.dart';
import 'package:authapp/views/pages/loading_page.dart';
import 'package:authapp/views/widget_tree.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:authapp/app/mobile/auth_service.dart';

class AuthLayout extends StatelessWidget {
  const AuthLayout({super.key, this.pageIfNotFound});

  final Widget? pageIfNotFound;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: authService,
      builder: (BuildContext context, dynamic service, Widget? child) {
        return StreamBuilder<User?>(
          stream: service.authStateChanges,
          builder: (context, snapshot) {
            Widget? widget;
            if (snapshot.connectionState == ConnectionState.waiting) {
              widget = LoadingPage();
            } else if (snapshot.hasData) {
              widget = HomePage();
            } else {
              widget = pageIfNotFound ?? WidgetTree();
            }
            return widget;
          },
        );
      },
    );
  }
}

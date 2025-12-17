import 'package:authapp/app/mobile/auth_service.dart';
import 'package:authapp/views/pages/Delete_account.dart';
import 'package:authapp/views/pages/change_pass.dart';
import 'package:authapp/views/pages/update_username.dart';
import 'package:authapp/views/widget_tree.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String errorMessage = '';
  void logOut() async {
    try {
      await authService.value.signOut();

      errorMessage = '';
    } on FirebaseAuthException catch (e) {
      errorMessage = e.message ?? 'There was an error';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
              height: 200.0,
              width: double.infinity,
              color: Colors.teal[800],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome ',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    authService.value.currentUser!.displayName ?? 'User',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return UpdateUsername();
                  },
                ),
              );
              setState(() {});
            },
            title: Text('Update Username'),
            trailing: Icon(Icons.forward),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ChangePass();
                  },
                ),
              );
            },
            title: Text('Change Password'),
            trailing: Icon(Icons.forward),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return DeleteAccount();
                  },
                ),
              );
            },
            title: Text('Delete my account'),
            trailing: Icon(Icons.forward),
          ),
          ListTile(
            onTap: () {
              logOut();
            },
            title: Text('Log Out'),
            trailing: Icon(Icons.forward),
          ),
          Text(errorMessage, style: TextStyle(color: Colors.red)),
        ],
      ),
    );
  }
}

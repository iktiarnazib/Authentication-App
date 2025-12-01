import 'package:authapp/views/pages/change_pass.dart';
import 'package:authapp/views/pages/update_username.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(height: 50.0),
        ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return UpdateUsername();
                },
              ),
            );
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
          onTap: () {},
          title: Text('Delete my account'),
          trailing: Icon(Icons.forward),
        ),
      ],
    );
  }
}

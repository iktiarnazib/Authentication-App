import 'dart:convert';

import 'package:authapp/app/mobile/auth_service.dart';
import 'package:authapp/data/notifiers.dart';
import 'package:authapp/views/pages/profile_page.dart';
import 'package:authapp/views/widget_tree.dart';
import 'package:authapp/views/widgets/bottom_navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

Future<Activity> fetchActivity() async {
  final response = await http.get(
    Uri.parse('https://bored-api.appbrewery.com/random'),
  );

  if (response.statusCode == 200) {
    return Activity.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load activity');
  }
}

class Activity {
  final String activity;
  final double availability; // number in API
  final String type;
  final int participants;
  final double price;
  final String accessibility; // string in API
  final String duration; // string in API
  final bool kidFriendly; // bool in API
  final String link;
  final String key;

  const Activity({
    required this.activity,
    required this.availability,
    required this.type,
    required this.participants,
    required this.price,
    required this.accessibility,
    required this.duration,
    required this.kidFriendly,
    required this.link,
    required this.key,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      activity: json['activity'] as String,
      availability: (json['availability'] as num).toDouble(),
      type: json['type'] as String,
      participants: json['participants'] as int,
      price: (json['price'] as num).toDouble(),
      accessibility: json['accessibility'] as String,
      duration: json['duration'] as String,
      kidFriendly: json['kidFriendly'] as bool,
      link: (json['link'] ?? '') as String,
      key: json['key'] as String,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedPage = 0;
  String errorMessage = '';
  final user = authService.value.currentUser;
  late Future<Activity> futureActivity;

  @override
  void initState() {
    super.initState();
    futureActivity = fetchActivity();
  }

  void _refreshActivity() {
    setState(() {
      futureActivity = fetchActivity();
    });
  }

  bool showFirst = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          child: Text("Authapp", style: TextStyle(fontWeight: FontWeight.bold)),
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
      ),
      body: ValueListenableBuilder(
        valueListenable: selectedPageNotifier,
        builder: (BuildContext context, dynamic selectedPage, Widget? child) {
          return selectedPage == 0
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'This is how API works:',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FutureBuilder<Activity>(
                            future: futureActivity,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final data = snapshot.data!;
                                return Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Card(
                                    elevation: 20,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Data fetched from API:',
                                            style: TextStyle(
                                              color: Colors.amber,
                                            ),
                                          ),
                                          Text(
                                            data.activity,
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 12),

                                          Text("Type: ${data.type}"),
                                          Text(
                                            "Participants: ${data.participants}",
                                          ),
                                          Text("Price: ${data.price}"),
                                          Text(
                                            "Availability: ${data.availability}",
                                          ),
                                          Text(
                                            "Accessibility: ${data.accessibility}",
                                          ),
                                          Text("Duration: ${data.duration}"),
                                          Text(
                                            "Kid Friendly: ${data.kidFriendly}",
                                          ),
                                          Text("Key: ${data.key}"),

                                          if (data.link.isNotEmpty) ...[
                                            const SizedBox(height: 8),
                                            Text(
                                              "Link: ${data.link}",
                                              style: const TextStyle(
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ],

                                          const SizedBox(height: 16),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: OutlinedButton.icon(
                                              label: Text(
                                                'Get Another Activity',
                                              ),
                                              onPressed: _refreshActivity,
                                              icon: Icon(Icons.casino),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }

                              if (snapshot.hasError) {
                                return Text("Error: ${snapshot.error}");
                              }

                              return const CircularProgressIndicator();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              : ProfilePage();
        },
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:json_serialize_test/models/user_model.dart';

final dio = Dio();
const apiUsers = 'https://jsonplaceholder.typicode.com/users';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<User> users = [];

  @override
  void initState() {
    super.initState();
    dio.get(apiUsers).then((value) {
      users = (value.data as List<dynamic>)
          .map((json) => User.fromJson(json))
          .toList();
      setState(() {});
    }).catchError((err) => debugPrint('WOWOWO: $err'));
  }

  @override
  Widget build(BuildContext context) {
    print("users: ${users.toString()}");
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: const Text('JSON Serializable')),
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (_, idx) {
            final user = users[idx];
            return ListTile(
              title: Text(user.name),
            );
          }),
    ));
  }
}

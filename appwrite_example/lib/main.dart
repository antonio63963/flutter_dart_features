// https://www.youtube.com/watch?v=t9jS1m-oK4k

import 'package:appwrite_example/data/auth_api.dart';
import 'package:appwrite_example/view/screens/login_screen.dart';
import 'package:appwrite_example/view/screens/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  // runApp(const MyApp());
  runApp(ChangeNotifierProvider(
      create: ((context) => AuthApi()), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final value = context.watch<AuthApi>().status;
    print('TOP CHANGE Value changed to: $value!');

    return MaterialApp(
      title: 'Appwrite Auth Demo',
      debugShowCheckedModeBanner: false,
      home: value == AuthStatus.uninitialized
          ? const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            )
          : value == AuthStatus.authenticated
              ? const TabsScreen()
              : const LoginScreen(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFFE91052),
        ),
        scaffoldBackgroundColor: Colors.white,
        bottomNavigationBarTheme:
            BottomNavigationBarThemeData(backgroundColor: Colors.white),
      ),
    );
  }
}

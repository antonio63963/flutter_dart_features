import 'package:appwrite/appwrite.dart';
import 'package:appwrite_example/data/auth_api.dart';
import 'package:appwrite_example/view/screens/messages_screen.dart';
import 'package:appwrite_example/view/screens/register_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  bool loading = false;

  signIn() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Dialog(
            backgroundColor: Colors.transparent,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircularProgressIndicator(),
                ]),
          );
        });

    try {
      final AuthApi appwrite = context.read<AuthApi>();
      await appwrite.createEmailSession(
        email: emailTextController.text,
        password: passwordTextController.text,
      );
      Navigator.pop(context);
    } on AppwriteException catch (e) {
      Navigator.pop(context);
      showAlert(title: 'Login failed', text: e.message.toString());
    }
  }

  showAlert({required String title, required String text}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(text),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Ok'))
            ],
          );
        });
  }

  signInWithProvider(String provider) {
    try {
      context.read<AuthApi>().signInWithProvider(provider: provider);
    } on AppwriteException catch (e) {
      showAlert(title: 'Login failed', text: e.message.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appwrite App'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: emailTextController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passwordTextController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  signIn();
                },
                icon: const Icon(Icons.login),
                label: const Text("Sign in"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterScreen()));
                },
                child: const Text('Create Account'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MessagesScreen()));
                },
                child: const Text('Read Messages as Guest'),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => signInWithProvider('google'),
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.black),
                    child: SvgPicture.asset('lib/assets/google_icon.svg',
                        width: 12),
                  ),
                  ElevatedButton(
                    onPressed: () => signInWithProvider('apple'),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    child: SvgPicture.asset(
                      'lib/assets/apple_icon.svg',
                      width: 12,
                      colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => signInWithProvider('github'),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    child: SvgPicture.asset(
                      'lib/assets/github_icon.svg',
                      width: 12,
                      colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => signInWithProvider('twitter'),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    child: SvgPicture.asset('lib/assets/twitter_icon.svg',
                        width: 12),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

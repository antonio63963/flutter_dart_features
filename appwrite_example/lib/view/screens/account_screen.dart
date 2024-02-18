import 'package:appwrite_example/data/auth_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  late String? email;
  late String? username;
  TextEditingController jobController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final AuthApi appwrite = context.read<AuthApi>();
    email = appwrite.email;
    username = appwrite.username;
    appwrite.getUserPreferences().then((value) {
      if (value.data.isNotEmpty) {
        setState(() {
          jobController.text = value.data['job'];
        });
      }
    });
  }

  savePreferences() {
    final AuthApi appwrite = context.read<AuthApi>();
    appwrite.updatePreferences(job: jobController.text);
    const snackbar = SnackBar(content: Text('Preferences updated!'));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  signOut() {
    final AuthApi appwrite = context.read<AuthApi>();
    appwrite.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Account'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                signOut();
              },
            ),
          ],
        ),
        body: Center(
          child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Welcome back $username!',
                      style: Theme.of(context).textTheme.headlineSmall),
                  Text('$email'),
                  const SizedBox(height: 40),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(children: [
                        TextField(
                          controller: jobController,
                          decoration: const InputDecoration(
                            labelText: 'Your job',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextButton(
                          onPressed: () => savePreferences(),
                          child: const Text('Save Preferences'),
                        ),
                      ]),
                    ),
                  )
                ],
              )),
        ));
  }
}
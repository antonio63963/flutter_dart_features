import 'package:appwrite_example/data/auth.service.dart';
import 'package:appwrite_example/data/auth_api.dart';
import 'package:appwrite_example/view/screens/auth_screen/validators.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth';

  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Email'),
                  TextFormField(
                    validator: Validators.name,
                    controller: _emailController,
                  ),
                  const Text('Password'),
                  TextFormField(
                    validator: Validators.name,
                    controller: _pwdController,
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final resp = await AuthApi().createUser(
                            email: _emailController.text,
                            password: _pwdController.text,
                          );
                          // final resp = await AuthService.register(
                          //   _emailController.text,
                          //   _pwdController.text,
                          // );
                          debugPrint('Regiter: ${resp.toString()}');
                        }
                      },
                      child: const Text("Ok"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

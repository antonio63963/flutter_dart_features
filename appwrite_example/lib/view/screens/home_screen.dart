import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:appwrite_example/data/auth_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key, required this.title});

  final String title;

  AuthApi authService = AuthApi();

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthStatus status = AuthStatus.unauthenticated;
  List<models.Country> _countries = [];

  void _getCountries() {
    Locale locale = Locale(widget.authService.client);
    locale.listCountries().then((response) {
      setState(() {
        _countries = response.countries;
      });
    });
  }

  void createUser() async {
    final resp = await widget.authService.createUser(
      email: 'texxxx@gmail.com',
      password: '11111111',
    );
    print('Response: $resp');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    status = context.watch<AuthApi>().status;
    print('TOP CHANGE NOTIFIER PROVIDER: $status');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () =>
                // Navigator.of(context).pushNamed(AuthScreen.routeName),
                createUser(),
            icon: const Icon(Icons.login),
          ),
        ],
      ),
      body: status == AuthStatus.uninitialized
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _countries.length,
              itemBuilder: (_, idx) {
                final country = _countries[idx];
                return ListTile(
                  title: Text(country.name),
                  subtitle: Text(country.code),
                );
              }),
      floatingActionButton: FloatingActionButton(
        onPressed: _getCountries,
        child: Icon(Icons.map),
      ),
    );
  }
}

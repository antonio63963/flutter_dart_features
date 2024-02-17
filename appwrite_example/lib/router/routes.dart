import 'package:appwrite_example/view/screens/auth_screen/auth_screen.dart';

import '../view/screens/home_screen.dart';

final routes = {
  '/': (context) => HomeScreen(
        title: 'Home',
      ),
  AuthScreen.routeName: (context) => const AuthScreen(),
};

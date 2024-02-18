// https://www.youtube.com/watch?v=t9jS1m-oK4k

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:appwrite_example/constants.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

enum AuthStatus {
  uninitialized,
  authenticated,
  unauthenticated,
}

class AuthApi extends ChangeNotifier {
  Client client = Client();
  late final Account account;

  late User _currentUser;

  AuthStatus _status = AuthStatus.unauthenticated;

  User get currentUser => _currentUser;
  AuthStatus get status => _status;
  String? get username => _currentUser.name;
  String? get email => _currentUser.email;
  String? get userId => _currentUser.$id;

  //Constractor
  AuthApi() {
    init();
    loadUser();
  }

  init() {
    client
        .setEndpoint(APPWRITE_URL)
        .setProject(APPWRITE_PROJECT_ID)
        .setSelfSigned();
    account = Account(client);
  }

  loadUser() async {
    try {
      final user = await account.get();
      _status = AuthStatus.authenticated;
      _currentUser = user;
    } catch (err) {
      _status = AuthStatus.unauthenticated;
    } finally {
      notifyListeners();
    }
  }

  Future<User> createUser(
      {required String email, required String password}) async {
    try {
      final user = await account.create(
        userId: uuid.v4(),
        email: email,
        password: password,
        name: "Simon G",
      );
      return user;
    } catch (err) {
      throw AppwriteException('Something has gone wrong on create user.../n ERR: $err');
    } finally {
      notifyListeners();
    }
  }

  Future<Session> createEmailSession({
    required String email,
    required String password,
  }) async {
    try {
      final session =
          await account.createEmailSession(email: email, password: password);
      _currentUser = await account.get();
      _status = AuthStatus.authenticated;
      return session;
    } finally {
      notifyListeners();
    }
  }

  signOut() async {
    try {
      await account.deleteSession(sessionId: 'current');
      _status = AuthStatus.unauthenticated;
    } finally {
      notifyListeners();
    }
  }

  Future<Preferences> getUserPreferences() async {
    return await account.getPrefs();
  }

  updatePreferences({required String job}) async {
    return account.updatePrefs(prefs: {'job': job});
  }
}

import 'package:appwrite/appwrite.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class AuthService {
  static late Client _client;

  AuthService() {
    _client = Client()
        .setEndpoint('https://cloud.appwrite.io/v1')
        .setProject('65cf2e5cbf9f2a1b6aaf');
  }

  Client get client => _client;

   register(String email, String password) async {
    try {
      final account = Account(_client);
      final res = await account.create(
          userId: uuid.v4(), email: email, password: password);
      print("Account: ${res}");
    } on AppwriteException catch (err) {
      throw AppwriteException(err.message);
    }
  }

  static login({required String email, required String password}) async {
    final account = Account(_client);
    return account.createEmailSession(email: email, password: password);
  }

  static getUserData() {
    try {
      final account = Account(_client);
      return account.get();
    } on AppwriteException catch (err) {
      throw AppwriteException(err.message);
    }
  }
}

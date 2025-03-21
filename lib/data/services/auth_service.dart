import 'package:anaquel/app/appwrite.dart';
import 'package:appwrite/enums.dart';
import 'package:appwrite/models.dart';
import 'package:appwrite/appwrite.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final Account account = Appwrite.init();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  Future<bool> isLoggedIn() async {
    try {
      await user;
      await _saveSessionState(true);
      return true;
    } catch (e) {
      await _saveSessionState(false);
      return false;
    }
  }

  Future<User> get user async => await account.get();

  Future<void> signInWithGoogle() async {
    await account.createOAuth2Session(provider: OAuthProvider.google);
    await _saveSessionState(true);
  }

  Future<void> signOut() async {
    try {
      await account.deleteSession(sessionId: 'current');
      await _saveSessionState(false);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _saveSessionState(bool isActive) async {
    await secureStorage.write(
      key: 'anaquel_session_active',
      value: isActive ? 'true' : 'false',
    );
  }
}

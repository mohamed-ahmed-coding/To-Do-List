import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_do_list/data/firestore_data.dart';

abstract class AuthData {
  Future<void> signUp(String email, String password, String confirmPassword);
  Future<void> login(String email, String password);
}

class AuthRemote extends AuthData {
  static final RegExp _emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');

  @override
  Future<void> login(String email, String password) async {
    final trimmedEmail = email.trim();
    final trimmedPassword = password.trim();

    if (trimmedEmail.isEmpty || trimmedPassword.isEmpty) {
      throw Exception("Email and password cannot be empty");
    }
    if (!_emailRegex.hasMatch(trimmedEmail)) {
      throw Exception("The Email is Not Formally Enterd");
    }
    if (trimmedPassword.length < 6) {
      throw Exception("Password must be at least 6 characters");
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: trimmedEmail,
        password: trimmedPassword,
      );
    } catch (e) {
      if (e == 'invalid-email') {
        throw Exception("The Email is Not Formally Enterd");
      }
      if (e == 'wrong-password') {
        throw Exception("Incorrect Password");
      }
      rethrow;
    }
  }

  @override
  Future<void> signUp(String email, String password, String confirmPassword) async {
    if (password != confirmPassword) {
      throw Exception("Passwords do not match");
    }
    if (password.length < 6) {
      throw Exception("Password must be at least 6 characters");
    }
    if (email.isEmpty || password.isEmpty) {
      throw Exception("Email and password cannot be empty");
    }
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.trim(), password: password.trim()).then((value) {
      FirestoreData().CreateUser(email.trim());
    });
  }

}

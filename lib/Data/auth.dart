import 'package:supabase_flutter/supabase_flutter.dart';

class Auth {
  final supa = Supabase.instance.client.auth;
//singUp
  Future<void> singUp(String email, String password) async {
    await supa.signUp(password: password, email: email);
  }
// login
  Future<void> login(String email, String password) async {
    await supa.signInWithPassword(password: password, email: email);
  }
// logOut
  Future<void> logOut() async {
    await supa.signOut();
  }
}

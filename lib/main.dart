import 'package:flutter/material.dart';
import 'package:flutter_application_1/Presentation/Screens/home_screen.dart';
import 'package:flutter_application_1/Presentation/Screens/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://klzvnskrrpwgwzuensvm.supabase.co',
    publishableKey: 'sb_publishable_s3YeQeIzTkbfNgoyWluQzg_bqsNrTLm',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Supabase.instance.client.auth.currentUser != null ? HomeScreen(): LoginScreen(),
    );
  }
}

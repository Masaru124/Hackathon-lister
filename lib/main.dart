import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'hackathon_list_page.dart'; // Your list page

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load the .env file from assets folder
  await dotenv.load(fileName: "assets/.env");

  // Get the values from the .env file
  final supabaseUrl = dotenv.env['SUPABASE_URL'];
  final supabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY'];

  // Check if env values exist
  if (supabaseUrl == null || supabaseAnonKey == null) {
    throw Exception(
        "Supabase URL or Anon Key not found in .env. Make sure assets/.env exists!");
  }

  // Initialize Supabase
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hackathon Explorer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HackathonListPage(),
    );
  }
}

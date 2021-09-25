import 'package:flutter/material.dart';
import 'package:smart_journey_experience/screens/appLandingPage.dart';
import 'screens/appLandingPage.dart';
import 'package:smart_journey_experience/screens/app_help.dart';
import 'package:smart_journey_experience/screens/app_about_us.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Digital Airport Experience',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        routes: {
          '/': (context) => HomePage(),
          '/home': (context) => HomePage(),
          '/help': (context) => Help(),
          '/about_us': (context) => AboutUS()
        });
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent.shade100,
        title: Text('Digital Airport Experience'),
        centerTitle: true,
      ),
      body: Container(
        child: LoginScreen(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tech_test/provider/courseModel.dart';
import 'package:tech_test/screens/signinPage.dart';
import 'package:tech_test/screens/signUpPage.dart';
import 'package:tech_test/widgets/custom_bottom_bar.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (context) => CourseModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SignInPage()
      // const BottomBar(),
      // SignInScreen()
    );
  }
}

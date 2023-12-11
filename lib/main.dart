import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:menu_app/view/pages/HomePage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
      overlays: []);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        datePickerTheme: DatePickerThemeData(
          headerForegroundColor: Colors.white,
          backgroundColor: Color.fromARGB(255, 245, 1, 74),
        ),
      ),
      home: const HomePage(),
    );
  }
}

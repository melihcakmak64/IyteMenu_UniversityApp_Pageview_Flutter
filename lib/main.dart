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
      title: 'IyteMenu',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 231, 223, 223)),
        useMaterial3: true,
        datePickerTheme: DatePickerThemeData(
          headerForegroundColor: Colors.white,
          backgroundColor: Color.fromARGB(255, 247, 71, 71),
          cancelButtonStyle: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, // Set the text color to black
          ),
          confirmButtonStyle: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, // Set the text color to black
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'global.dart';
import 'intro_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  bool? isIntroVisited = prefs.getBool("isIntroVisited") ?? false;
  runApp(
    MaterialApp(
      initialRoute: (isIntroVisited == false) ? "intro_page" : "/",
      theme: ThemeData(
        primarySwatch: buildMaterialColor(Global.appColor),
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => const HomePage(),
        "intro_page": (context) => const IntroPage(),
      },
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Home Page"),
      ),
    );
  }
}

MaterialColor buildMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
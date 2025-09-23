import 'package:flutter/material.dart';
import 'package:my_change_notifier/my_change_notifier.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final controller = ThemeController();

  void onChangeTheme() {
    setState(() {});
  }

  @override
  void initState() {
    controller.addListener(onChangeTheme);

    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(onChangeTheme);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: controller.isDarkTheme ? ThemeData.dark() : ThemeData.light(),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = ThemeController();

  void onChangeTheme() {
    setState(() {});
  }

  @override
  void initState() {
    controller.addListener(onChangeTheme);

    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(onChangeTheme);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListTile(
          onTap: () => controller.changeTheme(),
          title: Text('Tema escuro'),
          trailing: Switch(
            value: controller.isDarkTheme,
            onChanged: (_) => controller.changeTheme(),
          ),
        ),
      ),
    );
  }
}

class ThemeController extends MyChangeNotifier {
  ThemeController._internal();

  static final ThemeController _instance = ThemeController._internal();

  factory ThemeController() => _instance;

  bool isDarkTheme = false;

  void changeTheme() {
    isDarkTheme = !isDarkTheme;
    notifyListeners();
  }
}

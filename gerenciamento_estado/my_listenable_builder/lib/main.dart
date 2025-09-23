import 'package:flutter/material.dart';
import 'package:my_listenable_builder/my_change_notifier.dart';
import 'package:my_listenable_builder/my_transitions.dart';

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

  @override
  Widget build(BuildContext context) {
    return MyListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: controller.isDarkTheme ? ThemeData.dark() : ThemeData.light(),
          home: MyHomePage(title: 'Flutter Demo Home Page'),
        );
      },
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListTile(
          onTap: () => controller.changeTheme(),
          title: Text('Tema escuro'),
          trailing: MyListenableBuilder(
            listenable: controller,
            builder: (context, _) {
              return Switch(
                value: controller.isDarkTheme,
                onChanged: (_) => controller.changeTheme(),
              );
            },
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

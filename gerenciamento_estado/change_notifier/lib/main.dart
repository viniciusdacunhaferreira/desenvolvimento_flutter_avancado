import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ThemeController();

    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) => MaterialApp(
        title: 'Flutter Demo',
        theme: controller.isDarkTheme ? ThemeData.dark() : ThemeData.light(),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key, required this.title});

  final String title;

  final controller = ThemeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListTile(
          onTap: () => controller.changeTheme(),
          title: Text('Tema escuro'),
          trailing: ListenableBuilder(
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

class ThemeController extends ChangeNotifier {
  ThemeController._internal();

  static final ThemeController _instance = ThemeController._internal();

  factory ThemeController() => _instance;

  bool isDarkTheme = false;

  void changeTheme() {
    isDarkTheme = !isDarkTheme;
    notifyListeners();
  }
}

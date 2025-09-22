import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ThemeController();

    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, value, _) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: value ? ThemeData.dark() : ThemeData.light(),
          home: MyHomePage(title: 'Flutter Demo Home Page'),
        );
      },
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
          trailing: ValueListenableBuilder(
            valueListenable: controller,
            builder: (context, value, _) {
              return Switch(
                value: value,
                onChanged: (_) => controller.changeTheme(),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ThemeController extends ValueNotifier<bool> {
  ThemeController._internal() : super(false);

  static final ThemeController _instance = ThemeController._internal();

  factory ThemeController() => _instance;

  void changeTheme() {
    value = !value;
  }
}

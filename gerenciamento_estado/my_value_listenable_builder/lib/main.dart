import 'package:flutter/material.dart';
import 'package:my_value_listenable_builder/my_change_notifier.dart';
import 'package:my_value_listenable_builder/my_value_listenable_builder.dart';

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
    return MyValueListenableBuilder(
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = ThemeController();

  final counter = MyValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
              onTap: () => controller.changeTheme(),
              title: Text('Tema escuro'),
              trailing: MyValueListenableBuilder(
                valueListenable: controller,
                builder: (context, value, _) {
                  return Switch(
                    value: value,
                    onChanged: (_) => controller.changeTheme(),
                  );
                },
                onRebuild: () {
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Tema alterado'),
                      behavior: SnackBarBehavior.floating,
                      action: SnackBarAction(
                        label: 'Desfazer',
                        onPressed: controller.changeTheme,
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('You have pushed the button this many times:'),
                    MyValueListenableBuilder(
                      valueListenable: counter,
                      builder: (context, value, _) {
                        return Text(
                          '$value',
                          style: Theme.of(context).textTheme.headlineMedium,
                        );
                      },
                      rebuildWhen: (_, newValue) {
                        return newValue.isOdd;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          counter.value++;
        },
      ),
    );
  }
}

class ThemeController extends MyValueNotifier<bool> {
  ThemeController._internal() : super(false);

  static final ThemeController _instance = ThemeController._internal();

  factory ThemeController() => _instance;

  void changeTheme() {
    value = !value;
  }
}

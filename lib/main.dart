import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/config/theme/app_theme.dart';
import 'package:todo_app/entities/todo.dart';
import 'package:todo_app/ui/screens/home_screen.dart';

Future<void> main() async {
  // Hive
  WidgetsFlutterBinding.ensureInitialized();
  Hive.registerAdapter(TodoAdapter());
  await Hive.initFlutter();
  await Hive.openBox<Todo>('allTodosBox');

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) =>
          const ProviderScope(child: MyApp()), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //DevicePreview
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      //DevicePreview

      theme: AppTheme().getAppTheme(),
      darkTheme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}

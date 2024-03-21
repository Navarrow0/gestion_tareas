import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gestion_tareas/core/data/models/local/tasks/tasks_local_model.dart';
import 'package:gestion_tareas/core/presentation/screens/users_screen.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  await Hive.initFlutter();
  Hive..registerAdapter(LocalUserTasksAdapter())
  ..registerAdapter(LocalTaskModelAdapter());

  runApp(const ProviderScope(
    child: MyApp(),
  ));

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
              fontFamily: 'Poppins',
              visualDensity: VisualDensity.comfortable),
          home: const UsersScreen(),
        );
      },
    );
  }
}

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:flutter_template/store/global_state/global_state.dart';
import 'package:flutter_template/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  GlobalBinding().dependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeController themeController = Get.find();
  final AppRouter appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'flutter-template',
        theme: createLightThemeData(),
        darkTheme: createDarkThemeData(),
        themeMode: themeController.themeMode.value,
        routerConfig: appRouter.router,
      );
    });
  }
}

ThemeData createLightThemeData() {
  return ThemeData.light(useMaterial3: true).copyWith(
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      scrolledUnderElevation: 0,
    ),
    iconButtonTheme: (!kIsWeb && Platform.isMacOS)
        ? IconButtonThemeData(
            style: ButtonStyle(
              overlayColor: WidgetStateProperty.all(Colors.transparent),
            ),
          )
        : null,
    dividerColor: Colors.transparent,
    dialogBackgroundColor: Colors.white,
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: const Color.fromARGB(255, 9, 185, 85),
      ),
    ),
  );
}

ThemeData createDarkThemeData() {
  return ThemeData.dark(useMaterial3: true).copyWith(
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      scrolledUnderElevation: 0,
    ),
    iconButtonTheme: (!kIsWeb && Platform.isMacOS)
        ? IconButtonThemeData(
            style: ButtonStyle(
              overlayColor: WidgetStateProperty.all(Colors.transparent),
            ),
          )
        : null,
    dividerColor: Colors.transparent,
    dialogBackgroundColor: const Color.fromARGB(255, 48, 48, 48),
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: const Color.fromARGB(255, 9, 185, 85),
      ),
    ),
  );
}

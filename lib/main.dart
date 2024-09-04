import '/screens/authentication.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';

import 'Translates/app_translate.dart';

void main() async{
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: AppTranslations(),
      locale: const Locale('kh', 'KH'), // Set the default language here
      fallbackLocale: const Locale('en', 'US'),
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Authentication(),
    );
  }
}

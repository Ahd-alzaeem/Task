import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'core/init/dependency_injection.dart';
import 'core/routing/routing_manager.dart';
import 'features/connectivity/internet_connection_checker.dart';
import 'features/home/presentation/screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await DependencyInjection.inject();
  await GetStorage.init();
  await InternetConnectionChecker.initConnectivity();

  print('DDDDD ${InternetConnectionChecker.isConnected}');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      getPages: RoutingManager.pages,
    );
  }
}

import 'package:binkstoreap/controllers/menu_controller.dart';
import 'package:binkstoreap/screens/dashboard/dashboard.dart';
import 'package:binkstoreap/screens/navigations/navigationbar.dart';
import 'package:binkstoreap/screens/products/productScreen.dart';
import 'package:binkstoreap/screens/layouts/sizeLayout.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

int initScreen = 0;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyBoAzXL9GUY6royKhZ2ZiNQLTRCt69ALWQ",
      appId: "1:1055369430536:web:75f1246a2b92647a49b3bd",
      messagingSenderId: "1055369430536",
      projectId: "binkstoreapp",
    ),
  );
  Get.put(MenuController());
  runApp(
    GetMaterialApp(
        initialRoute: '/',
        defaultTransition: Transition.leftToRight,
        debugShowCheckedModeBanner: false,
        transitionDuration: const Duration(milliseconds: 500),
        getPages: [
          GetPage(name: '/', page: () => MyApp()),
          GetPage(name: '/productScreen', page: () => atProductScreen()),
        ],
        home: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bink Store',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        dialogBackgroundColor: Colors.white,
        primarySwatch: Colors.grey,
        fontFamily: 'Recoleta',
        accentColor: Colors.white,
      ),
      initialRoute: initScreen == 0 ? 'onboarding' : 'dashboard',
      routes: {
        'onboarding': (context) => sizeLayout(),
        'dashboard': (context) => sizeLayout(),
      },
    );
  }
}

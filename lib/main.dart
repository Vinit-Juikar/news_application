import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:news_application/widgets/bottom_navigation_bar.dart';

import 'home_screen/main_news_homescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      builder: (context, _) => const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
                   
              body: NewsHomeScreen(),
              bottomNavigationBar: BottomNavigationBarForHomeScreen(),
            ),
          ),
        ),
      ),
    );
  }
}

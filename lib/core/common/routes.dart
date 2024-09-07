import 'package:flutter/material.dart';
import 'package:ina17_test/feature/home/presentation/page/home_page.dart';
import 'package:ina17_test/feature/take_photo/presentation/page/take_photo_page.dart';
import 'package:ina17_test/feature/testing/testing_page.dart';

class Routes {
  static const String homePage = '/';
  static const String testingPage = '/testing';
  static const String takePhotoPage = '/take-photo';
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.testingPage:
      return MaterialPageRoute(
        builder: (BuildContext context) => const TestingPage(),
        settings: settings,
      );
    case Routes.homePage:
      return MaterialPageRoute(
        builder: (BuildContext context) => const HomePage(),
        settings: settings,
      );
    case Routes.takePhotoPage:
      return MaterialPageRoute(
        builder: (BuildContext context) => const TakePhotoPage(),
        settings: settings,
      );
    default:
      return MaterialPageRoute(
        builder: (BuildContext context) => const Scaffold(
          body: Center(
            child: Text('Route not defined'),
          ),
        ),
        settings: settings,
      );
  }
}

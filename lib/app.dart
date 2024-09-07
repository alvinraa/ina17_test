import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ina17_test/core/common/helper.dart';
import 'package:ina17_test/core/common/navigation.dart';
import 'package:ina17_test/core/common/routes.dart';
import 'package:ina17_test/core/theme/style.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  ThemeType themeType = ThemeType.light;

  @override
  Widget build(BuildContext context) {
    // set device only portait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Styles.appTheme(context, themeType),
      navigatorKey: navigatorKey,
      onGenerateRoute: generateRoute,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context),
          child: GestureDetector(
            onTap: () {
              Helper.hideKeyboard(context);
            },
          ),
        );
      },
    );
  }
}

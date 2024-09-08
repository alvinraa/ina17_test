import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ina17_test/core/common/helper.dart';
import 'package:ina17_test/core/common/navigation.dart';
import 'package:ina17_test/core/common/routes.dart';
import 'package:ina17_test/core/theme/style.dart';
import 'package:ina17_test/feature/take_photo/bloc/take_photo_bloc.dart';

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

    return MultiBlocProvider(
      providers: [
        // add list of bloc
        BlocProvider(create: (context) => TakePhotoBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Styles.appTheme(context, themeType),
        navigatorKey: navigatorKey,
        onGenerateRoute: generateRoute,
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(1.0)),
            child: GestureDetector(
              onTap: () {
                Helper.hideKeyboard(context);
              },
              child: child!,
            ),
          );
        },
      ),
    );
  }
}

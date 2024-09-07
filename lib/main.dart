import 'package:flutter/material.dart';
import 'package:ina17_test/app.dart';
import 'package:ina17_test/core/client/client.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await Client().setupClient();
  initializeDateFormatting();
  runApp(const App());
}

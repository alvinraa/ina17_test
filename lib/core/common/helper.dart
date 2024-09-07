import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Helper {
  static void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }

  static String formatDateTime(DateTime? date, {String format = 'dd/MM/yyyy'}) {
    if (date == null) return "-";
    String formattedDate = DateFormat(format, "id_ID").format(date);
    return formattedDate;
  }
}

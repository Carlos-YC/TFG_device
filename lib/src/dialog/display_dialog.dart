import 'package:flutter/material.dart';

import 'error_dialog.dart';

class DisplayDialog {
  static displayErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (e) {
        return ErrorAlertDialog(message: message);
      },
    );
  }
}

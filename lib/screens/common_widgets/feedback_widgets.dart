import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zedfi/helpers/app_config.dart';

class FeedbackWidgets {
  final BuildContext context;
  const FeedbackWidgets(this.context);

  ///Generic confirmation Dialog, catering iOS and Android.
  ///Provide the proceed button text in case of iOS, which defaults to
  ///OK if not provided.
  Future<bool> showConfirmationDialog({
    required String title,
    required String message,
    String positiveButtonText = 'OK',
  }) async {
    final _title = Text(title);
    final _content = Text(message);

    final _dialog = Platform.isAndroid
        ? AlertDialog(
            title: _title,
            content: _content,
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Colors.red,
                ),
                onPressed: () => Navigator.pop(context),
              ),
              IconButton(
                icon: const Icon(
                  Icons.check,
                  color: Colors.green,
                ),
                onPressed: () => Navigator.pop(context, true),
              ),
            ],
          )
        : CupertinoAlertDialog(
            title: _title,
            content: _content,
            actions: [
              CupertinoDialogAction(
                child: const Text('Cancel'),
                onPressed: () => Navigator.pop(context),
              ),
              CupertinoDialogAction(
                child: Text(
                  positiveButtonText,
                  style: AppConfig.getTextStyle(
                    textColor: Colors.red,
                  ),
                ),
                onPressed: () => Navigator.pop(context, true),
              ),
            ],
          );
    return await showDialog(
      context: context,
      builder: (context) => _dialog,
    );
  }

  void showSuccessSnackBar({
    required String snackBarText,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(_getSnackbar(
      icon: Icons.check_circle,
      text: snackBarText,
      bgColor: Colors.green,
    ));
  }

  void showFailureSnackBar({
    required String snackBarText,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(_getSnackbar(
      icon: Icons.cancel,
      text: snackBarText,
      bgColor: Colors.red,
    ));
  }

  void showWarningSnackBar({
    required String snackBarText,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(_getSnackbar(
      icon: Icons.warning,
      text: snackBarText,
      bgColor: Colors.deepOrangeAccent,
    ));
  }

  SnackBar _getSnackbar({
    required IconData icon,
    required String text,
    required Color bgColor,
  }) {
    return SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Text(
              text,
              style: AppConfig.getTextStyle(
                textColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
      duration: const Duration(seconds: 4),
      backgroundColor: bgColor,
      behavior: SnackBarBehavior.floating,
      action: SnackBarAction(
        label: 'Dismiss',
        textColor: Colors.white,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );
  }
}

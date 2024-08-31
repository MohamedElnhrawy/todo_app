import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_app/core/common/views/loader.dart';
import 'package:todo_app/core/common/widgets/rounded_button.dart';
import 'package:todo_app/core/extensions/context_extension.dart';
import 'package:todo_app/core/res/colours.dart';

class CoreUtils {
  const CoreUtils._();

  static void showSnakeBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colours.primaryColor,
          margin: const EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
  }

  static void showLoadingDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(
              child: Loader(),
            ));
  }

  static Future<File?> pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      return File(image.path);
    }
    return null;
  }

  static void showConfirmDialog(
      {required BuildContext context,
      required String message,
      required String buttonTitle,
      required VoidCallback onPress}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: SizedBox(
              height: 300,
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      message,
                      style: const TextStyle(
                          color: Colours.primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                    FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RoundedButton(
                            onPressed: onPress,
                            label: "",
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          RoundedButton(
                            onPressed: onPress,
                            label: "",
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  static void showCustomDialog({
    required BuildContext context,
    required String title,
    required String message,
    required String action1Title,
    required String action2Title,
    Color? action1Color,
    Color? action2Color,
    VoidCallback? action1,
    VoidCallback? action2,
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Center(
              child: Text(
            title,
            style: const TextStyle(
                color: Colours.primaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 25),
          )),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                Text(
                  message,
                  style: const TextStyle(
                      color: Colours.neutralTextColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 18),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                action1Title,
                style: TextStyle(
                    color: action1Color ?? Colours.redColor, fontSize: 14),
              ),
              onPressed: () {
                if (action1 != null) {
                  action1();
                } else {
                  Navigator.of(context).pop();
                }
              },
            ),
            TextButton(
                child: Text(
                  action2Title,
                  style: TextStyle(
                      color: action1Color ?? Colours.primaryColor,
                      fontSize: 14),
                ),
                onPressed: () {
                  if (action2 != null) {
                    action2();
                  } else {
                    Navigator.of(context).pop();
                  }
                }),
          ],
        );
      },
    );
  }

  static void showDateTimePicker({
    required BuildContext context,
    required void Function(DateTime) callBack,
  }) {
    DatePicker.showDateTimePicker(
      context,
      showTitleActions: true,
      onConfirm: (date) {
        callBack(date); // Pass the selected date and time to the callback
      },
      currentTime: DateTime.now(),
      locale: context.isAR ? LocaleType.ar : LocaleType.en,
    );
  }



}

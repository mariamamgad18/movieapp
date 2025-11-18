import 'package:flutter/material.dart';
import 'package:movieapp/Utils/AppColors.dart';
class MyDialog {
  static void show({
    required BuildContext context,
    required String title,
    required String message,
    required VoidCallback onPressed,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          contentPadding: EdgeInsets.zero,
          content: SizedBox(
            width: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Appcolors.yellowColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Text(
                    title,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    message,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Appcolors.yellowColor,
                    ),
                    onPressed: onPressed,
                    child: const Text(
                      "OK",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

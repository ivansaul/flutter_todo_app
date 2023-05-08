import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDialogDeleteTodo extends StatelessWidget {
  final String content;
  final void Function()? onPressedDelete;

  const CustomDialogDeleteTodo({
    super.key,
    required this.content,
    required this.onPressedDelete,
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Container(
          height: 45,
          width: 45,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 20,
                spreadRadius: 0,
                offset: Offset(0, 0),
              )
            ],
            color: Colors.white,
          ),
          child: const Icon(
            Icons.delete_sweep_outlined,
            color: Colors.red,
          ),
        ),
        content: Text(
          content,
          textAlign: TextAlign.center,
          style: GoogleFonts.roboto(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: const Color(0xff9C9A9A),
          ),
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: <Widget>[
          TextButton(
            child: Text(
              "Cancel",
              style: GoogleFonts.roboto(
                fontSize: 15,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            onPressed: onPressedDelete,
            child: Text(
              "Delete",
              style: GoogleFonts.roboto(
                fontSize: 15,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

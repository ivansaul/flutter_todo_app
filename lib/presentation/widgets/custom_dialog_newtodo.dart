import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/presentation/provider/providers.dart';

class CustomdialogNewTodo extends ConsumerWidget {
  final void Function()? onPressedCreate;
  const CustomdialogNewTodo({
    Key? key,
    required this.onPressedCreate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final textEditingController = TextEditingController();
    final FocusNode focusNode = FocusNode();

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Column(
          children: [
            Container(
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
                Icons.note_alt_outlined,
                color: Color.fromARGB(255, 143, 128, 128),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                'New task',
                style: GoogleFonts.roboto(
                  fontSize: 23,
                  color: const Color.fromARGB(255, 143, 128, 128),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        content: SizedBox(
          height: 80,
          child: TextField(
            focusNode: focusNode,
            maxLines: null,
            expands: true,
            style: GoogleFonts.roboto(
              color: const Color.fromARGB(255, 128, 124, 124),
            ),
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              filled: false,
              hintText: 'What are you planning?',
              hintStyle: GoogleFonts.roboto(
                color: const Color(0xff9C9A9A),
              ),
            ),
            // controller: textEditingController,
            onChanged: (value) {
              ref.read(dscNewTodoProvider.notifier).update((state) => value);
            },
            onTapOutside: (event) {
              focusNode.unfocus();
            },
          ),
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: <Widget>[
          TextButton(
            child: Text(
              "Cancel",
              style: GoogleFonts.roboto(
                fontSize: 15,
                color: Colors.red,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            onPressed: onPressedCreate,
            child: Text(
              "Create",
              style: GoogleFonts.roboto(
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

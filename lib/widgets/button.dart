import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Button extends StatelessWidget {
  const Button({Key? key, this.onPressed, required this.text, this.padding})
      : super(key: key);
  final dynamic onPressed;
  final String text;
  final dynamic padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding == null ? const EdgeInsets.symmetric(horizontal: 25, vertical: 15) : padding,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: GoogleFonts.robotoSlab(
              fontWeight: FontWeight.bold, color: Colors.white),
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Color(0xff000000))),
      ),
    );
  }
}

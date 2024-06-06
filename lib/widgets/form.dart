import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Forms extends StatelessWidget {
  const Forms({Key? key, this.controller, required this.label, this.icon, this.obscure = false})
      : super(key: key);
  final dynamic controller;
  final String label;
  final dynamic icon;
  final dynamic obscure;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        style: GoogleFonts.robotoSlab(),
        decoration: InputDecoration(
          prefixIcon: Padding(
              padding: EdgeInsets.all(15.0),
              child: Icon(
                icon,
                color: Colors.grey,
              )),
          labelText: label,
          labelStyle: GoogleFonts.robotoSlab(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
          fillColor: Colors.grey[200],
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(40),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class AppTheme {
  static const textColor =  Color.fromARGB(255, 0, 0, 0);
  static const iconColor =  Color.fromARGB(255, 0, 0, 0);
  static const color = Color.fromARGB(199, 152, 179, 238);
  static const bottomColor =  Color.fromARGB(54, 73, 72, 72);
  static const foundColor = BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Colors.white,
          Color.fromARGB(255, 139, 190, 233),
        ],
    ),
  );
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    // colores del tema claro
    scaffoldBackgroundColor: textColor,
        appBarTheme: AppBarTheme(
          color: textColor,
          titleTextStyle: GoogleFonts.lato(
            color: textColor,
            fontSize: 28.5,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: iconColor,
          size: 35.0
        ),

        // estilo de botones
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(textColor),
            foregroundColor: MaterialStateProperty.all(color),
            textStyle: MaterialStateProperty.all(
              GoogleFonts.pacifico(
                fontSize: 25.0
              ),
            ),
          )
        ),

        // estilo de los textos
        textTheme: TextTheme(
          // Títulos de primer nivel
          headlineLarge: GoogleFonts.acme(
            fontSize: 23.0,
            fontWeight: FontWeight.bold,
            color: textColor,
            decoration: TextDecoration.underline,
            decorationColor: color, 
            decorationStyle: TextDecorationStyle.double,
            decorationThickness: 1.5,
          ),
          
          headlineMedium: GoogleFonts.alexandria(
            fontSize: 20.5,
            fontWeight: FontWeight.w700,
            color: textColor,

          ),

          // Fuennte para textos muy pequeños
          bodySmall: GoogleFonts.pacifico(
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
            color: textColor,
            fontStyle: FontStyle.italic
          ), 
        )
  );
}
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SobrePage extends StatelessWidget {
  const SobrePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF7FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF265F95),
        foregroundColor: Colors.white,
        title: Text(
          'Sobre',
          style: GoogleFonts.chewy(),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            'Glicogotas - Desvendando o Diabetes',
            textAlign: TextAlign.center,
            style: GoogleFonts.chewy(
              color: const Color(0xFF265F95),
              fontSize: 28,
            ),
          ),
        ),
      ),
    );
  }
}

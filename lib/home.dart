import 'package:flutter/material.dart';
import 'package:glicogotas_appv2/Livro/cards.dart';
import 'package:google_fonts/google_fonts.dart';

class TelaHome extends StatelessWidget {
  const TelaHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF7FF),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Glicogotas',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.chewy(
                    color: const Color(0xFF265F95),
                    fontSize: 44,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Livros educativos',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.chewy(
                    color: const Color(0xFF008AD7),
                    fontSize: 26,
                  ),
                ),
                const SizedBox(height: 40),
                FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF265F95),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 16,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const LivroCardsPage(),
                      ),
                    );
                  },
                  child: const Text('Abrir livros'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

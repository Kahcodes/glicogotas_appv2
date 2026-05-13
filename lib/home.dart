import 'package:flutter/material.dart';
import 'package:glicogotas_appv2/Livro/cards.dart';
import 'package:glicogotas_appv2/Personagens/glicogotas.dart';
import 'package:glicogotas_appv2/Video/youtube_video_page.dart';
import 'package:google_fonts/google_fonts.dart';

class TelaHome extends StatelessWidget {
  const TelaHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF7FF),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/glicogotas_logo.png',
                  height: 132,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 18),
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
                _HomeButton(
                  label: 'Abrir livros',
                  color: const Color(0xFF265F95),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const LivroCardsPage(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                _HomeButton(
                  label: 'Conhecer personagens',
                  color: const Color(0xFFF4719C),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const PersonagensPage(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                _HomeButton(
                  label: 'Assistir video',
                  color: const Color(0xFFE84242),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const YoutubeVideoPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HomeButton extends StatelessWidget {
  const _HomeButton({
    required this.label,
    required this.color,
    required this.onPressed,
  });

  final String label;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(
            horizontal: 28,
            vertical: 16,
          ),
        ),
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class YoutubeVideoPage extends StatelessWidget {
  const YoutubeVideoPage({super.key});

  static final Uri _videoUrl = Uri.parse(
    'https://www.youtube.com/watch?v=Ohb8ur_wRr8',
  );

  Future<void> _openYoutube(BuildContext context) async {
    final opened = await launchUrl(
      _videoUrl,
      mode: LaunchMode.externalApplication,
    );

    if (!opened && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nao foi possivel abrir o YouTube neste aparelho.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF7FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF265F95),
        foregroundColor: Colors.white,
        title: const Text('Video'),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/glicogotas_logo.png',
                  height: 112,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 28),
                Text(
                  'Lita - Diabetes Tipo 1',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.chewy(
                    color: const Color(0xFF265F95),
                    fontSize: 34,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'O video sera aberto no YouTube.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: const Color(0xFF3C5870),
                  ),
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: 260,
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFFE84242),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                    ),
                    onPressed: () => _openYoutube(context),
                    icon: const Icon(Icons.play_arrow_rounded),
                    label: const Text('Assistir no YouTube'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

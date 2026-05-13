import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glicogotas_appv2/Personagens/bobo.dart';
import 'package:glicogotas_appv2/Personagens/lita.dart';
import 'package:glicogotas_appv2/configuracoes.dart';
import 'package:glicogotas_appv2/controleaudio.dart';
import 'package:glicogotas_appv2/home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:glicogotas_appv2/main.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Certifique-se de que routeObserver está importado

class PersonagemReiPage extends StatefulWidget {
  const PersonagemReiPage({super.key});

  @override
  PersonagemReiPageState createState() => PersonagemReiPageState();
}

class PersonagemReiPageState extends State<PersonagemReiPage> with RouteAware {
  final AudioManager _audioManager = AudioManager();

  // Função para reproduzir o áudio
  Future<void> _saveCurrentPage(int page) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('current_page', page);
  }

  // Função para reproduzir o áudio
  @override
  void initState() {
    super.initState();
    _saveCurrentPage(2); // Salva o número da página atual
    _audioManager.play(
        'audio/audioPersonagens/hiper.mp3', context); // Reproduz o áudio
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute<dynamic>);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _audioManager.stop(); // Para o áudio ao sair da página
    _audioManager.dispose();
    super.dispose();
  }

  @override
  void didPushNext() {
    _audioManager.stop(); // Para o áudio ao ir para a próxima página
  }

  @override
  void didPopNext() {
    _audioManager.play('audio/audioPersonagens/hiper.mp3',
        context); // Reinicia o áudio ao voltar
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF7FF),
      body: LayoutBuilder(
        builder: (context, constraints) {
          ScreenUtil.init(
            context,
            designSize: const Size(360, 690),
            minTextAdapt: true,
          );

          return Stack(
            children: [
              // Fundo com as listras
              Positioned.fill(
                child: SvgPicture.asset(
                  'assets/images/fundo-rei.svg',
                  fit: BoxFit.cover,
                ),
              ),

              // Botão de voltar no topo esquerdo
              Positioned(
                top: 40.h,
                left: 16.w,
                child: IconButton(
                  iconSize: 30.sp,
                  icon: const Icon(
                    Icons.home_rounded,
                    color: Color.fromARGB(255, 0, 132, 255),
                  ),
                  onPressed: () {
                    _audioManager
                        .stop(); // Para o áudio ao ir para a tela inicial
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TelaHome()),
                    );
                  },
                ),
              ),

              // Botão de configurações no topo direito
              Positioned(
                top: 40.h,
                right: 16.w,
                child: IconButton(
                  iconSize: 30.sp,
                  icon: const Icon(
                    Icons.settings,
                    color: Color.fromARGB(255, 0, 132, 255),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const ConfigDialog(); // Chama o diálogo de configurações
                      },
                    );
                  },
                ),
              ),

              // Nome do personagem (Rei da Hiper) centralizado
              Positioned(
                top: 0.15.sh,
                left: 0,
                right: 0,
                child: Stack(
                  alignment: Alignment.center, // Alinha os textos exatamente
                  children: [
                    // Texto branco (borda)
                    Text(
                      'Rei da Hiper',
                      style: GoogleFonts.chewy(
                        fontSize: 0.13.sw,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 8
                          ..color =
                              const Color(0xFFFFFEFF), // Cor da borda branca
                        shadows: [
                          Shadow(
                            color:
                                Colors.black.withAlpha((0.25 * 255).toInt()),

                            offset: Offset(3.0, 3.0),
                            blurRadius: 5.0,
                          ),
                        ],
                      ),
                    ),
                    // Texto vermelho
                    Text(
                      'Rei da Hiper',
                      style: GoogleFonts.chewy(
                        fontSize: 0.13.sw,
                        color: const Color(0xFFEF291D), // Cor vermelha
                      ),
                    ),
                  ],
                ),
              ),

              // A bola do personagem no fundo
              Positioned(
                top: 0.28.sh,
                left: 0,
                right: 0,
                child: Center(
                  child: SvgPicture.asset(
                    'assets/images/eclipse-rei.svg',
                    height: 0.36.sh, // Aumentei ligeiramente a bola
                  ),
                ),
              ),

              // Personagem sobreposta à bola
              Positioned(
                top: 0.22.sh,
                left: 0,
                right: -10,
                child: Center(
                  child: SvgPicture.asset(
                    'assets/images/rei-da-hiper.svg',
                    height: 0.50.sh,
                  ),
                ),
              ),

              // Descrição do personagem
              Positioned(
                bottom: 0.20.sh,
                left: 20.w,
                right: 20.w,
                child: Stack(
                  alignment: Alignment
                      .center, // Alinhamento central para as camadas de texto
                  children: [
                    // Texto branco (borda)
                    Text(
                      'O Rei da Hiper se forma quando o açúcar está elevado. É hora de cuidar do equilíbrio do corpo!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.chewy(
                        fontSize: 0.06.sw,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 8
                          ..color =
                              const Color(0xFFFFFEFF), // Cor da borda branca
                        shadows: [
                          Shadow(
                            color:
                                Colors.black.withAlpha((0.25 * 255).toInt()),

                            offset: Offset(3.0, 3.0),
                            blurRadius: 5.0,
                          ),
                        ],
                      ),
                    ),
                    // Texto vermelho
                    Text(
                      'O Rei da Hiper se forma quando o açúcar está elevado. É hora de cuidar do equilíbrio do corpo!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.chewy(
                        fontSize: 0.06.sw,
                        color: const Color(0xFFEF291D), // Cor vermelha
                      ),
                    ),
                  ],
                ),
              ),

              // Botões de navegação laterais
              Positioned(
                bottom: 0.08.sh,
                left:
                    20.w, // Ajuste para ficar mais próximo da lateral esquerda
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: const Color(0xFFEF291D),
                    size: 48.sp,
                  ),
                  onPressed: () {
                    _audioManager.stop(); // Para o áudio ao navegar
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PersonagemLitaPage()),
                    ); // Ação do botão voltar
                  },
                ),
              ),
              Positioned(
                bottom: 0.08.sh,
                right:
                    20.w, // Ajuste para ficar mais próximo da lateral direita
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: const Color(0xFFEF291D),
                    size: 48.sp,
                  ),
                  onPressed: () {
                    _audioManager.stop(); // Para o áudio ao navegar
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PersonagemBoboPage()),
                    ); // Ação do botão avançar
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

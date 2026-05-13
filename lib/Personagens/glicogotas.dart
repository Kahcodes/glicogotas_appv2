import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glicogotas_appv2/Personagens/betinho.dart';
import 'package:glicogotas_appv2/Personagens/bobo.dart';
import 'package:glicogotas_appv2/Personagens/fe.dart';
import 'package:glicogotas_appv2/Personagens/insulins.dart';
import 'package:glicogotas_appv2/Personagens/lita.dart';
import 'package:glicogotas_appv2/Personagens/pumps.dart';
import 'package:glicogotas_appv2/Personagens/rei.dart';
import 'package:glicogotas_appv2/configuracoes.dart';
import 'package:glicogotas_appv2/controleaudio.dart';
import 'package:glicogotas_appv2/home.dart';
import 'package:glicogotas_appv2/main.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PersonagensPage extends StatefulWidget {
  const PersonagensPage({super.key});

  @override
  PersonagensPageState createState() => PersonagensPageState();
}

class PersonagensPageState extends State<PersonagensPage> with RouteAware {
  final AudioManager _audioManager = AudioManager();
  final PageController _pageController =
      PageController(); // Controlador do PageView
  int _currentPage = 0;

  final List<Widget> _pages = const [
    PersonagensContent(),
    PersonagemLitaPage(),
    PersonagemReiPage(),
    PersonagemBoboPage(),
    PersonagemFePage(),
    PersonagemInsulinsPage(),
    PersonagemPumpsPage(),
    PersonagemBetinhoPage(),
  ];

  // Função para reproduzir o áudio
  @override
  void initState() {
    super.initState();
    _audioManager.play(
        'audio/audioPersonagens/bemvindos.mp3', context); // Reproduz o áudio
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
    _audioManager.play('audio/audioPersonagens/bemvindos.mp3',
        context); // Reinicia o áudio ao voltar
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF265F95),
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: _pages.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return AnimatedBuilder(
                  animation: _pageController,
                  builder: (context, child) {
                    double scale = 1.0;
                    double opacity = 1.0;

                    if (_pageController.position.haveDimensions) {
                      double page = _pageController.page ?? 0.0;
                      scale = (1 - (index - page).abs()).clamp(0.85, 1.0);
                      opacity = (1 - (index - page).abs()).clamp(0.5, 1.0);
                    }

                    return Transform.scale(
                      scale: scale,
                      child: Opacity(
                        opacity: opacity,
                        child: _pages[index],
                      ),
                    );
                  },
                );
              },
            ),
            // Indicador de navegação (Dots)
            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pages.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: 8,
                    width: _currentPage == index ? 12 : 8,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? Colors.yellow
                          : Colors.white.withAlpha((0.5 * 255).toInt()),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ),
            // Botão de avançar ou voltar
            if (_currentPage > 0)
              Positioned(
                top: MediaQuery.of(context).size.height * 0.5,
                left: 16,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios,
                      color: Color.fromARGB(0, 255, 255, 255)),
                  onPressed: () {
                    _audioManager.stop();
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ),
            if (_currentPage < _pages.length - 1)
              Positioned(
                top: MediaQuery.of(context).size.height * 0.5,
                right: 16,
                child: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios,
                      color: Color.fromARGB(0, 255, 255, 255)),
                  onPressed: () {
                    _audioManager.stop();
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class PersonagensContent extends StatelessWidget {
  const PersonagensContent({super.key});

  @override
  Widget build(BuildContext context) {
    final audioManager = AudioManager();

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          ScreenUtil.init(
            context,
            designSize: const Size(360, 690),
            minTextAdapt: true,
          );

          return Stack(
            children: [
              // O fundo azul cobrindo toda a tela
              Positioned.fill(
                child: SvgPicture.asset(
                  'assets/images/fundo-azul.svg',
                  fit: BoxFit.cover,
                ),
              ),

              // Botão de configurações no topo direito
              Positioned(
                top: 40.h,
                right: 16.w,
                child: IconButton(
                  iconSize: 30.sp,
                  icon: const Icon(Icons.settings, color: Colors.white),
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

              // Título "Bem-Vindos" com contorno branco e sombra
              Positioned(
                top: 0.05.sh,
                left: 0,
                right: 0,
                child: Center(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          // Contorno branco
                          Text(
                            'Bem-Vindos',
                            style: GoogleFonts.chewy(
                              fontSize: 0.13.sw, // Fonte maior
                              fontWeight: FontWeight.w400,
                              shadows: [
                                Shadow(
                                  color: Colors.black
                                      .withAlpha((0.25 * 255).toInt()),
// Sombra suave
                                  offset: const Offset(
                                      3.0, 3.0), // Ajuste de sombra
                                  blurRadius: 5.0,
                                ),
                              ],
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 8
                                ..color = const Color(
                                    0xFFFFFEFF), // Cor do contorno (branca)
                            ),
                          ),
                          // Preenchimento rosa e sombra
                          Text(
                            'Bem-Vindos',
                            style: GoogleFonts.chewy(
                              color: const Color(
                                  0xFFF4719C), // Cor do preenchimento (rosa)
                              fontSize: 0.13.sw, // Fonte maior
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),

                      // Frase "À Turminha do Glicogotas!"
                      SizedBox(height: 5.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              // Contorno branco
                              Text(
                                'À Turminha do Glicogotas!',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.chewy(
                                  fontSize: 0.06.sw,
                                  fontWeight: FontWeight.w400,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black
                                          .withAlpha((0.25 * 255).toInt()),
                                      offset: const Offset(3.0, 3.0),
                                      blurRadius: 5.0,
                                    ),
                                  ],
                                  foreground: Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 5
                                    ..color = const Color(0xFFFFFEFF),
                                ),
                              ),
                              // Preenchimento rosa e sombra
                              Text(
                                'À Turminha do Glicogotas!',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.chewy(
                                  color: const Color(0xFFF4719C),
                                  fontSize: 0.06.sw,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // A imagem central ajustada para ficar parcialmente fora da tela
              Positioned(
                top: 0.20.sh, // Alinhamento vertical
                left: 0, // A imagem começará da borda esquerda
                right: 0, // A imagem terminará na borda direita
                child: Image.asset(
                  'assets/images/tela-inicial-perso.png', // Caminho da imagem
                  width: 1.sw, // Largura da imagem igual à largura da tela
                  fit: BoxFit.cover, // Ajuste da imagem sem distorcer
                ),
              ),

              // Botão de home no canto superior esquerdo
              Positioned(
                top: 40.h,
                left: 16.w,
                child: IconButton(
                  iconSize: 30.sp,
                  icon: const Icon(Icons.home_rounded, color: Colors.white),
                  onPressed: () {
                    audioManager.stop(); // Para o áudio ao voltar ao início
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TelaHome()),
                    );
                  },
                ),
              ),

              // Botão "Avançar"
              // Botão "Avançar"
              Positioned(
                bottom: 0.05.sh,
                right: 20.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        audioManager.stop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PersonagemLitaPage(),
                          ),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: 8.w),
                        child: Stack(
                          children: [
                            Text(
                              'Avançar',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.chewy(
                                fontSize: 26.sp,
                                fontWeight: FontWeight.w400,
                                shadows: [
                                  Shadow(
                                    color: Colors.black
                                        .withAlpha((0.25 * 255).toInt()),
                                    offset: const Offset(3.0, 3.0),
                                    blurRadius: 4.0,
                                  ),
                                ],
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 5
                                  ..color = const Color(0xFFFFFEFF),
                              ),
                            ),
                            Text(
                              'Avançar',
                              style: GoogleFonts.chewy(
                                fontSize: 26.sp,
                                color: const Color(0xFFF4719C),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: const Color(0xfff6aebf), // Cor do ícone
                        size: 38.sp,
                      ),
                      onPressed: () {
                        audioManager.stop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PersonagemLitaPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

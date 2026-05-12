import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:glicogotas_appv2/Livro/cards.dart';
import 'package:glicogotas_appv2/Livro/diabetes-livro/diabetes1.dart';
import 'package:glicogotas_appv2/Livro/diabetes-livro/diabetes2.dart';
import 'package:glicogotas_appv2/Livro/diabetes-livro/diabetes3.dart';
import 'package:glicogotas_appv2/Livro/diabetes-livro/diabetes4.dart';
import 'package:glicogotas_appv2/Livro/diabetes-livro/diabetes5.dart';
import 'package:glicogotas_appv2/Livro/diabetes-livro/diabetes6.dart';
import 'package:glicogotas_appv2/configuracoes.dart';
import 'package:glicogotas_appv2/controleaudio.dart';
import 'package:glicogotas_appv2/main.dart';
import 'package:glicogotas_appv2/sqlite.dart';

class CapaPage extends StatefulWidget {
  const CapaPage({super.key});

  @override
  State<CapaPage> createState() => _CapaPageState();
}

class _CapaPageState extends State<CapaPage> with RouteAware {
  final AudioManager _audioManager = AudioManager();
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Widget> _pages = const [
    CapaContent(),
    Diabetes1Page(),
    Diabetes2Page(),
    Diabetes3Page(),
    Diabetes4Page(),
    Diabetes5Page(),
    Diabetes6Page(),
  ];

  @override
  void initState() {
    super.initState();
    PageDatabase.instance.saveCurrentPage(1); // garante que começa na capa
    _audioManager.play('audio/titulo.mp3', context);
    _navigateToSavedPage();
  }

  Future<void> _navigateToSavedPage() async {
    final savedPage = await PageDatabase.instance.getCurrentPage();
    if (savedPage > 1) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => _getPageByNumber(savedPage)),
        );
      });
    }
  }

  Widget _getPageByNumber(int pageNumber) {
    if (pageNumber > 0 && pageNumber <= _pages.length) {
      return _pages[pageNumber - 1];
    }
    return const CapaContent();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute<dynamic>);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _audioManager.stop();
    _audioManager.dispose();
    super.dispose();
  }

  @override
  void didPushNext() {
    _audioManager.stop();
  }

  @override
  void didPopNext() {
    _audioManager.play('audio/titulo.mp3', context);
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
                setState(() => _currentPage = index);
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
                      child: Opacity(opacity: opacity, child: _pages[index]),
                    );
                  },
                );
              },
            ),

            // Indicadores
            Positioned(
              bottom: 16.h,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pages.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    height: 8.h,
                    width: _currentPage == index ? 12.w : 8.w,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? Colors.yellow
                          : Colors.white.withAlpha(127),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                ),
              ),
            ),

            // Botão voltar
            if (_currentPage > 0)
              Positioned(
                top: MediaQuery.of(context).size.height * 0.5,
                left: 16.w,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios,
                      color: Colors.transparent),
                  onPressed: () {
                    _audioManager.stop();
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ),

            // Botão avançar
            if (_currentPage < _pages.length - 1)
              Positioned(
                top: MediaQuery.of(context).size.height * 0.5,
                right: 16.w,
                child: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios,
                      color: Colors.transparent),
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

class CapaContent extends StatelessWidget {
  const CapaContent({super.key});

  @override
  Widget build(BuildContext context) {
    final audioManager = AudioManager();
    return Scaffold(
      backgroundColor: const Color(0xFF265F95),
      body: LayoutBuilder(
        builder: (context, constraints) {
          ScreenUtil.init(
            context,
            designSize: const Size(360, 690),
            minTextAdapt: true,
          );

          return Stack(
            children: [
              // Topo com botões
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 40.h, left: 16.w),
                    child: IconButton(
                      iconSize: 30.sp,
                      icon: const Icon(Icons.menu_book, color: Colors.white),
                      onPressed: () {
                        audioManager.stop();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LivroCardsPage()),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 40.h, right: 16.w),
                    child: IconButton(
                      iconSize: 30.sp,
                      icon: const Icon(Icons.settings, color: Colors.white),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => const ConfigDialog(),
                        );
                      },
                    ),
                  ),
                ],
              ),

              // Texto do título
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 100.h),
                  CustomPaint(
                      painter: ArcTextPainter(),
                      child: Container(height: 80.h)),
                  Text('DESCOMPLICANDO',
                      style: GoogleFonts.chewy(
                          fontSize: 36.sp, color: Colors.yellow)),
                  Text('o Diabetes',
                      style: GoogleFonts.chewy(
                          fontSize: 36.sp, color: Colors.yellow)),
                ],
              ),

              // Personagem
              Positioned(
                bottom: 0,
                left: 0,
                child: Image.asset(
                  "assets/images/talita_capa.png",
                  height: 290.h,
                  fit: BoxFit.cover,
                ),
              ),

              // Botão avançar

              Positioned(
                bottom: 0.08.sh,
                right: 20.w,
                child: GestureDetector(
                  onTap: () {
                    PageDatabase.instance.saveCurrentPage(2);
                    audioManager.stop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Diabetes1Page()),
                    );
                  },
                  child: Row(
                    children: [
                      Text(
                        'Avançar',
                        style: GoogleFonts.chewy(
                          fontSize: 28.sp,
                          color: Colors.yellow,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.yellow,
                        size: 36.sp,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// Pintura do texto em arco
class ArcTextPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    final textStyle = GoogleFonts.chewy(
        fontSize: 50, color: Colors.yellow, fontWeight: FontWeight.bold);

    const text = "GLICOGOTAS";
    final radius = size.width / 4;
    final centerX = size.width / 2;
    final centerY = size.height / 1.2;

    double startAngle = -pi / 2 - (160 * pi / 180) / 2;
    const totalAngle = 160 * pi / 180;
    const anglePerLetter = totalAngle / (text.length - 1);

    for (int i = 0; i < text.length; i++) {
      final angle = startAngle + (i * anglePerLetter);
      final offset =
          Offset(centerX + radius * cos(angle), centerY + radius * sin(angle));

      textPainter.text = TextSpan(text: text[i], style: textStyle);
      textPainter.layout();

      canvas.save();
      canvas.translate(offset.dx, offset.dy);
      canvas.rotate(angle + pi / 2);
      textPainter.paint(
          canvas, Offset(-textPainter.width / 2, -textPainter.height / 2));
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

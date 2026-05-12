import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glicogotas_appv2/Livro/cards.dart';
import 'package:glicogotas_appv2/Livro/insulina-livro/insulina2.dart';
import 'package:glicogotas_appv2/Livro/insulina-livro/insulina3.dart';
import 'package:glicogotas_appv2/Livro/insulina-livro/insulina4.dart';
import 'package:glicogotas_appv2/Livro/insulina-livro/insulina5.dart';
import 'package:glicogotas_appv2/Livro/insulina-livro/insulina6.dart';
import 'package:glicogotas_appv2/Livro/insulina-livro/insulina7.dart';
import 'package:glicogotas_appv2/Livro/insulina-livro/insulina8.dart';
import 'package:glicogotas_appv2/Livro/insulina-livro/insulina9.dart';
import 'package:glicogotas_appv2/controleaudio.dart';
import 'package:glicogotas_appv2/configuracoes.dart';
import 'package:glicogotas_appv2/main.dart'; // Importa o routeObserver
import 'package:glicogotas_appv2/sqlite.dart';

class Insulina1Page extends StatefulWidget {
  const Insulina1Page({super.key});

  @override
  State<Insulina1Page> createState() => _Insulina1PageState();
}

class _Insulina1PageState extends State<Insulina1Page> with RouteAware {
  final AudioManager _audioManager = AudioManager();
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Widget> _pages = const [
    Insulina1Content(),
    Insulina2Page(),
    Insulina3Page(),
    Insulina4Page(),
    Insulina5Page(),
    Insulina6Page(),
    Insulina7Page(),
    Insulina8Page(),
    Insulina9Page(),
  ];

  @override
  void initState() {
    super.initState();
    _audioManager.play('audio/pagina1insu.mp3', context);
    _navigateToSavedPage();
  }

  Future<void> _navigateToSavedPage() async {
    final savedPage = await PageDatabase.instance.getCurrentPage();
    if (savedPage > 1) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => _getPageByNumber(savedPage),
          ),
        );
      });
    }
  }

  Widget _getPageByNumber(int pageNumber) {
    if (pageNumber > 0 && pageNumber <= _pages.length) {
      return _pages[pageNumber - 1];
    }
    return const Insulina1Content();
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
    _audioManager.play('audio/pagina1insu.mp3', context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFfffcf3),
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
                          : Colors.white
                              .withAlpha((0.5 * 255).toInt()), // Correção aqui
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                ),
              ),
            ),
            if (_currentPage > 0)
              Positioned(
                top: MediaQuery.of(context).size.height * 0.5,
                left: 16.w,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios,
                      color: Color.fromARGB(0, 0, 0, 0)),
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
                right: 16.w,
                child: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios,
                      color: Color.fromARGB(0, 0, 0, 0)),
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

class Insulina1Content extends StatelessWidget {
  const Insulina1Content({super.key});

  @override
  Widget build(BuildContext context) {
    final audioManager = AudioManager();
    return Scaffold(
      backgroundColor: const Color(0xFFfffcf3),
      body: LayoutBuilder(
        builder: (context, constraints) {
          ScreenUtil.init(
            context,
            designSize: const Size(360, 690),
            minTextAdapt: true,
          );

          return Stack(
            children: [
              // Fundo da página
              Positioned.fill(
                child: SvgPicture.asset(
                  'assets/images/fundoinsulinas.svg',
                  fit: BoxFit.fill,
                ),
              ),

              // Personagem Lita
              Positioned(
                top: 0.31.sh,
                left: 0.02.sw,
                right: 0.02.sw,
                child: SvgPicture.asset(
                  'assets/images/lita-insulins.svg',
                  width: 0.6.sw,
                  height: 0.6.sh,
                ),
              ),

              // Balão de fala
              Positioned(
                top: 0.14.sh,
                left: 0.20.sw,
                right: 0.01.sw,
                child: SvgPicture.asset(
                  'assets/images/balao-ins-page1.svg',
                  width: 0.7.sw,
                ),
              ),

              // Ícone Home (por cima dos botões invisíveis)
              Positioned(
                top: 40.h,
                left: 16.w,
                child: IconButton(
                  iconSize: 30.sp,
                  icon: const Icon(
                    Icons.menu_book,
                    color: Color(0xFF265F95),
                  ),
                  onPressed: () {
                    audioManager
                        .stop(); // Para o áudio ao voltar à tela inicial
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LivroCardsPage()),
                    );
                  },
                ),
              ),

              // Ícone Configurações (por cima dos botões invisíveis)
              Positioned(
                top: 40.h,
                right: 16.w,
                child: IconButton(
                  iconSize: 30.sp,
                  icon: const Icon(
                    Icons.settings,
                    color: Color(0xFF265F95),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const ConfigDialog();
                      },
                    );
                  },
                ),
              ),

              // Botão de navegação próxima
              Positioned(
                bottom: 0.08.sh,
                right: 20.w,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Color(0xFF265F95),
                    size: 48.sp,
                  ),
                  onPressed: () {
                    audioManager.stop();
                    PageDatabase.instance.saveCurrentPage(2);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Insulina2Page()),
                    );
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

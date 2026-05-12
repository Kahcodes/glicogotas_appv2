import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glicogotas_appv2/Livro/dm2-livro/vovo1.dart';
import 'package:glicogotas_appv2/Livro/hiper-livro/hiper1.dart';
import 'package:glicogotas_appv2/Livro/hipo-livro/hipo1.dart';
import 'package:glicogotas_appv2/Livro/insulina-livro/insulina1.dart';
import 'package:glicogotas_appv2/Livro/pagina1.dart';
import 'package:glicogotas_appv2/controleaudio.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:glicogotas_appv2/Livro/capa.dart'; // Importa a página de capa
import 'package:glicogotas_appv2/home.dart'; // Importa a tela inicial
import 'package:glicogotas_appv2/configuracoes.dart'; // Importa o diálogo de configurações

class LivroCardsPage extends StatefulWidget {
  const LivroCardsPage({super.key});

  @override
  LivroCardsState createState() => LivroCardsState();
}

class LivroCardsState extends State<LivroCardsPage> with RouteAware {
  final AudioManager _audioManager = AudioManager();
  final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route is PageRoute) {
      routeObserver.subscribe(this, route);
    }
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPushNext() {
    _audioManager.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF7FF), // Fundo da página
      body: LayoutBuilder(
        builder: (context, constraints) {
          ScreenUtil.init(
            context,
            designSize: const Size(360, 690),
            minTextAdapt: true,
          );

          return Stack(
            children: [
              // Título "Selecione um Capítulo" com ícones
              Positioned(
                top: 40.h,
                left: 16.w,
                right: 16.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Ícone "Home"
                    IconButton(
                      iconSize: 30.sp,
                      icon: const Icon(
                        Icons.home_rounded,
                        color: Color(0xFF265F95), // Cor do ícone ajustada
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TelaHome()),
                        );
                      },
                    ),
                    Text(
                      'Selecione um Capítulo',
                      style: GoogleFonts.chewy(
                        color: const Color(0xFF265F95),
                        fontSize: 24.sp,
                      ),
                    ),
                    // Ícone "Configurações"
                    IconButton(
                      iconSize: 30.sp,
                      icon: const Icon(
                        Icons.settings,
                        color: Color(0xFF265F95), // Cor do ícone ajustada
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
                  ],
                ),
              ),

              // Grid de cards com espaçamento ajustado
              Padding(
                padding: EdgeInsets.only(
                    top: 120.h), // Ajusta os cards mais para baixo
                child: GridView.count(
                  crossAxisCount: 2,
                  padding: EdgeInsets.all(16.w),
                  crossAxisSpacing: 16.w,
                  mainAxisSpacing: 16.h,
                  children: [
                    // Card 1
                    GestureDetector(
                      onTap: () {
                        _audioManager.stop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CapaPage()),
                        );
                      },
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Stack(
                          children: [
                            Image.asset(
                              'assets/images/diabetes-capa.png',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Card 2
                    GestureDetector(
                      onTap: () {
                        _audioManager.stop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Pagina1Page()),
                        );
                      },
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Stack(
                          children: [
                            Image.asset(
                              'assets/images/pancreas-capa.png',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Card 3
                    /* GestureDetector(
                      onTap: () {
                        _audioManager.stop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CapaPage()),
                        );
                      },
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Stack(
                          children: [
                            Image.asset(
                              'assets/images/chaves-capa.png',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ],
                        ),
                      ),
                    ),*/
                    // Card 4
                    GestureDetector(
                      onTap: () {
                        _audioManager.stop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Insulina1Page()),
                        );
                      },
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Stack(
                          children: [
                            Image.asset(
                              'assets/images/insulina-capa.png',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ],
                        ),
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        _audioManager.stop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Hipo1Page()),
                        );
                      },
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Stack(
                          children: [
                            Image.asset(
                              'assets/images/card-hipo.png',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ],
                        ),
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        _audioManager.stop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Hiper1Page()),
                        );
                      },
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Stack(
                          children: [
                            Image.asset(
                              'assets/images/card-hiper.png',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ],
                        ),
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        _audioManager.stop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Vovo1Page()),
                        );
                      },
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Stack(
                          children: [
                            Image.asset(
                              'assets/images/card-vovo.png',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ],
                        ),
                      ),
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

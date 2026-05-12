import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glicogotas_appv2/Livro/cards.dart';
import 'package:glicogotas_appv2/Livro/pagina1.dart';
import 'package:glicogotas_appv2/Livro/pagina3.dart';
import 'package:glicogotas_appv2/configuracoes.dart';
import 'package:glicogotas_appv2/controleaudio.dart';
import 'package:glicogotas_appv2/main.dart'; // Importa o routeObserver
import 'package:glicogotas_appv2/sqlite.dart';

class Pagina2Page extends StatefulWidget {
  const Pagina2Page({super.key});

  @override
  Pagina2PageState createState() => Pagina2PageState();
}

class Pagina2PageState extends State<Pagina2Page> with RouteAware {
  final AudioManager _audioManager = AudioManager();

  // Função para reproduzir o áudio
  @override
  void initState() {
    super.initState();
    PageDatabase.instance.saveCurrentPage(2); // Salva o número da página atual
    _audioManager.play('audio/panc-pagina2.mp3', context); // Reproduz o áudio
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
    _audioManager.play(
        'audio/panc-pagina1.mp3', context); // Reinicia o áudio ao voltar
  }

  @override
  Widget build(BuildContext context) {
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
                  'assets/images/fundopaglivro.svg',
                  fit: BoxFit.fill,
                ),
              ),

              // Lita falando
              Positioned(
                top: 0.30.sh,
                right: 0.20.sw,
                child: SvgPicture.asset(
                  'assets/images/lita.svg',
                  height: 0.6.sh,
                ),
              ),

              // Balão de fala
              Positioned(
                top: 0.05.sh,
                left: 0.03.sw,
                right: 0.03.sw,
                child: SvgPicture.asset(
                  'assets/images/balão-page2.svg',
                  width: 1.2.sw,
                ),
              ),

              // Ícone Home
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
                    _audioManager
                        .stop(); // Para o áudio ao voltar à tela inicial
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LivroCardsPage()),
                    );
                  },
                ),
              ),

              // Ícone Configurações
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
                        return const ConfigDialog(); // Chama o diálogo de configurações
                      },
                    );
                  },
                ),
              ),

              // Botão de navegação anterior
              Positioned(
                bottom: 0.08.sh,
                left: 20.w,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Color(0xFF265F95),
                    size: 48.sp,
                  ),
                  onPressed: () {
                    _audioManager.stop();
                    PageDatabase.instance
                        .saveCurrentPage(1); // Salva o número da página atual
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Pagina1Page()),
                    ); // Volta para a página anterior
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
                    _audioManager.stop();
                    PageDatabase.instance
                        .saveCurrentPage(3); // Salva o número da página atual
                    // Para o áudio ao navegar
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Pagina3Page()),
                    ); // Vai para a próxima página
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

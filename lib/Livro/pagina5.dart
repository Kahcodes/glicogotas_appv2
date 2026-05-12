import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glicogotas_appv2/Livro/cards.dart';
import 'package:glicogotas_appv2/Livro/pagina6.dart';
import 'package:glicogotas_appv2/controleaudio.dart';
import 'package:glicogotas_appv2/main.dart';
import 'package:glicogotas_appv2/Livro/pagina4.dart';
import 'package:glicogotas_appv2/configuracoes.dart';
import 'package:glicogotas_appv2/sqlite.dart';

// Página 5 como StatefulWidget
class Pagina5Page extends StatefulWidget {
  const Pagina5Page({super.key});

  @override
  Pagina5PageState createState() => Pagina5PageState();
}

class Pagina5PageState extends State<Pagina5Page> with RouteAware {
  final AudioManager _audioManager = AudioManager();

  // Função para reproduzir o áudio
  @override
  void initState() {
    super.initState();
    PageDatabase.instance.saveCurrentPage(5); // Salva o número da página atual
    _audioManager.play('audio/panc-pagina5.mp3', context); // Reproduz o áudio
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
        'audio/panc-pagina4.mp3', context); // Reinicia o áudio ao voltar
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

              // Imagem do pâncreas
              Positioned(
                top: 0.33.sh,
                left: 0.05.sw,
                child: SvgPicture.asset(
                  'assets/images/pancreas.svg',
                  width: 0.9.sw,
                ),
              ),

              // Balão com texto
              Positioned(
                top: 0.16.sh,
                left: -0.04.sw,
                child: SvgPicture.asset(
                  'assets/images/balão-page5.svg',
                  width: 0.94.sw,
                ),
              ),

              // Botão Home
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
                    _audioManager.stop();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LivroCardsPage()),
                    );
                  },
                ),
              ),

              // Botão Configurações
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

              // Botão Voltar
              Positioned(
                bottom: 0.08.sh,
                left: 20.w,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_rounded,
                    size: 48.sp,
                    color: Color(0xFF265F95),
                  ),
                  onPressed: () {
                    _audioManager.stop();
                    PageDatabase.instance.saveCurrentPage(4);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Pagina4Page()),
                    );
                  },
                ),
              ),

              // Botão Avançar
              Positioned(
                bottom: 0.08.sh,
                right: 20.w,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 48.sp,
                    color: Color(0xFF265F95),
                  ),
                  onPressed: () {
                    _audioManager.stop();
                    PageDatabase.instance.saveCurrentPage(6);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Pagina6Page()),
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

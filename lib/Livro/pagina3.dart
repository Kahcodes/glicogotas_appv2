import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glicogotas_appv2/Livro/cards.dart';
import 'package:glicogotas_appv2/Livro/pagina2.dart'; // Importar a página anterior
import 'package:glicogotas_appv2/Livro/pagina4.dart'; // Importar a próxima página
import 'package:glicogotas_appv2/configuracoes.dart';
import 'package:glicogotas_appv2/controleaudio.dart';
import 'package:glicogotas_appv2/main.dart'; // Importa o routeObserver
import 'package:glicogotas_appv2/sqlite.dart';

class Pagina3Page extends StatefulWidget {
  const Pagina3Page({super.key});

  @override
  Pagina3PageState createState() => Pagina3PageState();
}

class Pagina3PageState extends State<Pagina3Page> with RouteAware {
  final AudioManager _audioManager = AudioManager();

  // Função para reproduzir o áudio
  @override
  void initState() {
    super.initState();
    PageDatabase.instance.saveCurrentPage(3); // Salva o número da página atual
    _audioManager.play('audio/panc-pagina3.mp3', context); // Reproduz o áudio
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
        'audio/panc-pagina2.mp3', context); // Reinicia o áudio ao voltar
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

              // Imagem da Lita
              Positioned(
                top: 0.25.sh, // Ajuste para mover para baixo
                left: 0.03.sw,
                child: Image.asset(
                  'assets/images/lita-pancreas.png',
                  width: 0.5.sw,
                  height: 0.5.sh,
                ),
              ),

              // Balão de fala
              Positioned(
                top: 0.22.sh,
                left: 0.01.sw,
                right: 0.03.sw,
                child: SvgPicture.asset(
                  'assets/images/balão-page3.svg',
                  width: 0.70.sw,
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

              // Botão para voltar
              Positioned(
                bottom: 0.08.sh,
                left: 20.w, // Ajuste para posicionar próximo da borda
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_rounded,
                    size: 48.sp, // Tamanho consistente com outras páginas
                    color: Color(0xFF265F95),
                  ),
                  onPressed: () {
                    _audioManager.stop();
                    PageDatabase.instance
                        .saveCurrentPage(2); // Para o áudio ao navegar
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Pagina2Page()),
                    ); // Navega para a página anterior
                  },
                ),
              ),

              // Botão para avançar
              Positioned(
                bottom: 0.08.sh,
                right: 20.w, // Ajuste para posicionar próximo da borda
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 48.sp, // Tamanho consistente com outras páginas
                    color: Color(0xFF265F95),
                  ),
                  onPressed: () {
                    _audioManager.stop();
                    PageDatabase.instance
                        .saveCurrentPage(4); // Para o áudio ao navegar
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Pagina4Page()),
                    ); // Navega para a próxima página
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

import 'package:flutter/material.dart';
import 'package:glicogotas_appv2/shared/repositories/configuracoes_repository.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glicogotas_appv2/sobre_page.dart';

class ConfigDialog extends StatefulWidget {
  const ConfigDialog({super.key});

  @override
  ConfigDialogState createState() => ConfigDialogState();
}

class ConfigDialogState extends State<ConfigDialog> {
  @override
  Widget build(BuildContext context) {
    final configuracoesProvider =
        Provider.of<ConfiguracoesRepository>(context, listen: true);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop(); // Fecha ao tocar fora
      },
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.all(10.w),
        child: GestureDetector(
          onTap: () {}, // Impede fechar ao tocar dentro
          child: Center(
            child: Container(
              width: 300.w,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFF008AD7),
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha((0.3 * 255).toInt()),
                    blurRadius: 10.r,
                    offset: Offset(0, 5.h),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Título + voltar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back,
                            color: Color(0xFFFEDE74)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'CONFIGURAÇÕES',
                            style: GoogleFonts.chewy(
                              fontSize: 23.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFFCB44E),
                              shadows: [
                                Shadow(
                                  color: Colors.black.withAlpha((0.5 * 255).toInt()),
                                  offset: Offset(2.w, 2.h),
                                  blurRadius: 4.r,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 48.w), // Balanceia layout
                    ],
                  ),
                  SizedBox(height: 20.h),

                  // Controle de som
                  FutureBuilder(
                    future: configuracoesProvider.getMusicOn(),
                    builder: (context, snapshot) {
                      return _buildSwitchOption(
                        'SOM',
                        snapshot.data ?? true,
                        (value) {
                          configuracoesProvider.switchMusicOn();
                        },
                      );
                    },
                  ),

                  SizedBox(height: 20.h),

                  Divider(color: Colors.white70),

                  SizedBox(height: 20.h),

                  // Sobre
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'SOBRE',
                        style: GoogleFonts.podkova(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Colors.black.withAlpha((0.5 * 255).toInt()),
                              offset: Offset(2.w, 2.h),
                              blurRadius: 4.r,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8.w),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SobrePage(),
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.help_outline,
                          color: Color(0xFFFEDE74),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSwitchOption(
      String title, bool value, ValueChanged<bool> onChanged) {
    return InkWell(
      onTap: () => onChanged(!value),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                value ? Icons.volume_up : Icons.volume_off,
                color: const Color(0xFFFCB44E),
              ),
              SizedBox(width: 8.w),
              Text(
                title,
                style: GoogleFonts.chewy(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black.withValues(alpha: 0.5),
                      offset: Offset(2.w, 2.h),
                      blurRadius: 4.r,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Switch(
            value: value,
            activeThumbColor: const Color(0xFFFCB44E),
            inactiveTrackColor: Colors.white,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

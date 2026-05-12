import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:glicogotas_appv2/shared/repositories/configuracoes_repository.dart';

class AudioManager {
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? _currentAssetPath;

  Future<void> setVolume(double volume) async {
    await _audioPlayer.setVolume(volume);
  }

  Future<void> play(String assetPath, BuildContext context) async {
    final configuracoesProvider =
        Provider.of<ConfiguracoesRepository>(context, listen: false);

    _currentAssetPath = assetPath; // Armazena o caminho atual

    if (configuracoesProvider.musicOn) {
      await _audioPlayer.play(AssetSource(assetPath));
    } else {
      await _audioPlayer.stop();
    }
  }

  Future<void> resume(BuildContext context) async {
    final configuracoesProvider =
        Provider.of<ConfiguracoesRepository>(context, listen: false);

    if (configuracoesProvider.musicOn && _currentAssetPath != null) {
      await _audioPlayer.play(AssetSource(_currentAssetPath!));
    }
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
  }

  bool get isPlaying => _audioPlayer.state == PlayerState.playing;

  void dispose() {
    _audioPlayer.dispose();
  }
}

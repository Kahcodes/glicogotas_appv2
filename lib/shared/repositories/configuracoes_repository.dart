import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfiguracoesRepository extends ChangeNotifier {
  bool _soundOn = true;
  bool _musicOn = true;
  double _volume = 0.7;
  String _language = 'Português';

  bool get soundOn => _soundOn;
  bool get musicOn => _musicOn;
  double get volume => _volume;
  String get language => _language;

  ConfiguracoesRepository() {
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _soundOn = prefs.getBool('soundOn') ?? true;
    _musicOn = prefs.getBool('musicOn') ?? true;
    _volume = prefs.getDouble('volume') ?? 0.7;
    _language = prefs.getString('language') ?? 'Português';
    notifyListeners();
  }

  // Som
  Future<bool> getSoundOn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('soundOn') ?? true;
  }

  Future<void> switchSoundOn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _soundOn = !_soundOn;
    await prefs.setBool('soundOn', _soundOn);
    notifyListeners();
  }

  // Música
  Future<bool> getMusicOn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('musicOn') ?? true;
  }

  Future<void> switchMusicOn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _musicOn = !_musicOn;
    await prefs.setBool('musicOn', _musicOn);
    notifyListeners();
  }

  // Volume
  Future<double> getVolume() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble('volume') ?? 0.7;
  }

  Future<void> setVolume(double value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _volume = value;
    await prefs.setDouble('volume', value);
    notifyListeners();
  }

  // Idioma (mantido no repo, mas não aparece no layout)
  Future<String> getLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('language') ?? 'Português';
  }

  Future<void> setLanguage(String lang) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _language = lang;
    await prefs.setString('language', lang);
    notifyListeners();
  }
}
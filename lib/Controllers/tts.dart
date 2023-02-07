import 'package:flutter_tts/flutter_tts.dart';

final FlutterTts flutterTts = FlutterTts();

setTtsConfig() {
  flutterTts.setSpeechRate(0.5);
  flutterTts.setVolume(1);
  flutterTts.setLanguage("ur-PK");
}

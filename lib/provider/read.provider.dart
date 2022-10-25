import 'package:flutter/widgets.dart';

import 'package:flutter_tts/flutter_tts.dart';


class SpeakProvider extends ChangeNotifier {

   FlutterTts tts = FlutterTts();

   Future speak({String? text}) async{
    await tts.setLanguage("en-US");
    await tts.setSpeechRate(0.5);
    await tts.setPitch(1);

    try {
      await tts.speak(text!);
    } catch (e) {
      debugPrint(e.toString()); 
      notifyListeners();
    }
   }

   void stop() async{
    await tts.stop();
    notifyListeners();
   }

}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ocr_voice_app/Model/ad_state.dart';
import 'package:ocr_voice_app/Screens/onboarding.dart';
import 'package:ocr_voice_app/Screens/pdfmaker.dart';
import 'package:ocr_voice_app/Screens/recongnization_page.dart';
import 'package:ocr_voice_app/provider/read.provider.dart';

import './Screens/homepage.dart';
import './Screens/namepage.dart';
import './Screens/readnote.dart';
import './provider/theme.provider.dart';

int? initScreen; 
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final initFuture = MobileAds.instance.initialize();
  final adState = AdState(initFuture);
  await SystemChrome.setPreferredOrientations([  //To force portrait and prevent orientation change
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen =  prefs.getInt("initScreen");
  await prefs.setInt("initScreen", 2);
  print('initScreen ${'initScreen'}');

  runApp(
    Provider.value(
      value: adState,
      builder: (context, child) => const MyApp(), 
    ),
    );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override

  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
   ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
   ),

    ChangeNotifierProvider(
    create: (context) => SpeakProvider(),
   ),

      
      ],
    builder: (context, child) {
    return MaterialApp(
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      themeMode: Provider.of<ThemeProvider>(context).themeMode,
      debugShowCheckedModeBanner: false,
      home: const Onboarding(),
      initialRoute: initScreen == 0 || initScreen == null ? 'first' : 'home',
      routes: {
        'home': (context) =>  HomePage(),
        'name' :(context) => const NamePage(),
        'first' :(context) => const Onboarding(),  
        'pdf' :(context) => const PdfMarker(),
        'read' :(context) => const ReadNote(),
        'recognize' :(context) => const RecognizePage(path: '',)
      },
          );
        }   
      );
     }
  
  }





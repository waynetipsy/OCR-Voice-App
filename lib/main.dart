import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ocr_voice_app/Screens/onboarding.dart';
import 'package:provider/provider.dart';
import './Screens/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './provider/theme.provider.dart';

int? initScreen;
Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([  //To force portrait and prevent orientation change
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
   SharedPreferences prefs = await SharedPreferences.getInstance(); 
  initScreen = await prefs.getInt("initScreen");
  await prefs.setInt("initScreen", 1);
  print('initScreen ${initScreen}');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override

  Widget build(BuildContext context) =>
   ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
     builder: (context, _) {
      final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      themeMode: themeProvider.themeMode,
      debugShowCheckedModeBanner: false,
      initialRoute: initScreen == 0 || initScreen == null ? "first" : "/",
      routes: {
        '/': (context) => const HomePage(),
        "first":(context) => const Onboarding()
      },
      );
     }
    );
  }





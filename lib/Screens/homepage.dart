
// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ocr_voice_app/Model/ad_state.dart';
import 'package:ocr_voice_app/Screens/savedtext.dart';

import '../Screens/appdrawer.dart';
import '../Widgets/alertdialogone.dart';
import '../Widgets/alertdialogtwo.dart';

class HomePage extends StatefulWidget {
  
  String? value;

  HomePage({
    Key? key,
    this.value,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? back;

  Future showToast(String message) async{
  await Fluttertoast.cancel();

  Fluttertoast.showToast(msg: message, fontSize: 18);

  
  }

  Widget labelDesign(Color color, String text) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 6),
      child: Text(
        text,
        
        style: const TextStyle(fontSize: 15,
        color: Colors.black
        ),
      ),
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: color, blurRadius: 2, spreadRadius: 2)],
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
    );
  }

  BannerAd?  _banner;
  InterstitialAd? _interstitialAd;
  

 @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getText();
    _createInterstitialAd();
    final adState = Provider.of<AdState>(context);
    adState.initialization.then((status) {
      setState(() {
        _banner = BannerAd( 
      size: AdSize.fullBanner, 
      adUnitId:  AdState.bannerAdUnitId!,
      listener: AdState.bannerAdListener,
      request: const AdRequest(),
       )..load();
      }
      );
      } 
    );
  }

     void _createInterstitialAd() {
      InterstitialAd.load(
        adUnitId: AdState.interstitialAdUnited!,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) => _interstitialAd = ad,
          onAdFailedToLoad: (error) => _interstitialAd = null,
          )
        );
     }

     void _showInterstitialAd () {
      if (_interstitialAd != null) {
        _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
          onAdDismissedFullScreenContent: (ad) {
            ad.dispose();
            _createInterstitialAd();
          },
          onAdFailedToShowFullScreenContent: (ad, error) {
            ad.dispose();
            _createInterstitialAd();
          },
        );
        _interstitialAd!.show();
        _interstitialAd = null;
      }
     }

   void getText() async{
     final SharedPreferences pref = await SharedPreferences.getInstance();
    back = pref.getString('text');
    setState(() {
      
    });
   }

    
  @override
  Widget build(BuildContext context) {

    return Scaffold(
       
      appBar: AppBar(
        actions: [
          IconButton(
            
            color: Colors.blue,
            onPressed: () {
            Navigator.push(context, MaterialPageRoute(
                builder: (_) => SavedText(),
                 ),
                );
               _showInterstitialAd();
            },
            icon: Icon(
              Icons.save_rounded,
              size: 27,
              ),
            )
        ],
        backgroundColor: Colors.black,
        elevation: 0,
        
        ),
      drawer: const AppDrawer(),

        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    _showInterstitialAd();
                  },
                  child: Card(
                    shadowColor: Colors.black,
                    elevation: 8,  
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    
                      ),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.blue,Colors.red],
                          begin: Alignment.topRight,
                          end: Alignment.bottomCenter
                          ),
                      ),
                      width: double.infinity,
                      height: 120,
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hello $back 😊',
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 15,
                        )
                      ),
                      SizedBox(height: 10),
                       Text('What feature do you want to use today?',
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20,
                        )
                      ),
                    ],
                
                      ),
                    )
                  ),
                ),
               const SizedBox(height: 40),
               Expanded(
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  children: [

                       GestureDetector(
                          onTap: () {

                            showDialog(
                         barrierDismissible: false,
                         context: context,
                         builder: (context) => const AlertDialogTwo(),
                        ).then((value) {
                        setState(() {});
                         });
                       
                          },
                        child: Card(               
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                                ),
                            shadowColor: Colors.blue,
                         elevation: 8,
                        child: Container(
                         padding: const EdgeInsets.all(23),
                          child: Column(
                            children: [
                              Icon(Icons.image,
                              color: Colors.white,
                              size: 65,
                              ),
                        SizedBox(height: 15,),
                              Text("Image to Text ",
                          style: GoogleFonts.lato(color: Colors.white,
                          fontSize: 14,
                        fontWeight: FontWeight.bold
                            ),
                            )
                           ],
                          ),
                                      
                        )
                       ),
                      ),

                    
                      GestureDetector(
                        onTap: () {
                       
                       showDialog(
                     barrierDismissible: false,
                      context: context,
                     builder: (context) => const AlertDialogOne(),
                     ).then((value) {
                     setState(() {});
                         });
                        
                        },
                      child: Card(
                        shadowColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                        
                        borderRadius: BorderRadius.circular(20)
                        ),
                      color: Colors.black,
                      elevation: 8,
                      child: Container(
                         padding: const EdgeInsets.all(23),
                        child: Column(
                          children: [
                            Icon(CupertinoIcons.camera,
                            color: Colors.white,
                            size: 65,
                            ),
                      SizedBox(height: 15,),
                            Text("Camera to Text ",
                        style: GoogleFonts.lato(color: Colors.white,
                        fontSize: 14,
                      fontWeight: FontWeight.bold
                        
                        ),
                            )
                          ],
                        ),
                                    
                            )
                        )
                      ),
                        GestureDetector(
                      onTap: () {
                      Navigator.of(context).
                      pushNamed('pdf');

                      },
                      child: Card(
                        shadowColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        
                        borderRadius: BorderRadius.circular(20)
                        ),
                      color: Colors.black,
                      elevation: 8,
                      child: Container(
                      padding: const EdgeInsets.all(23),
                        child: Column(
                          children:  [
                            Icon(Icons.file_copy,
                            color: Colors.white,
                            size: 65,
                            ),
                      SizedBox(height: 15,),
                            Text("Image to Pdf",
                        style: GoogleFonts.lato(color: Colors.white,
                        fontSize: 14,
                      fontWeight: FontWeight.bold
                        
                        ),
                       )
                      ],
                    ),
                    )
                     ),
                    ),

                        
                         GestureDetector (
                          onTap: () {
                          Navigator.of(context).pushNamed('read');
                          },
                          child: Card(
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                          ),
                          shadowColor: Colors.blue,
                          color: Colors.black,
                          elevation: 8,
                            child: Container(
                          padding: const EdgeInsets.all(23),
                          child: Column(
                            children:  [
                              Icon(Icons.mic,
                              color: Colors.white,
                              size: 65,
                              ),
                             SizedBox(height: 15,),
                              Text("Text to Sound",
                          style: GoogleFonts.lato(color: Colors.white,
                          fontSize: 14,
                            fontWeight: FontWeight.bold
                          
                              ),
                              )
                            ],
                          ),
                                        
                         )
                       ),
          
                  )

                ],

               ),
              
              ),
         
              ]
             
            )
            
          )
          
        ),
        bottomNavigationBar: _banner == null
        ? Container()
        : Container(
          margin: const EdgeInsets.only(bottom: 12),
          height: 50,
          child: AdWidget(ad: _banner!),
        )
    );
          
  }
}
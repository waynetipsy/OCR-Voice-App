import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ocr_voice_app/Utilis/image_crooper_page.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../Model/ad_state.dart';
import '../Screens/recongnization_page.dart';
import '../Utilis/image_picker_class.dart';
   

class AlertDialogOne extends StatefulWidget {
  const AlertDialogOne({super.key});

  @override
  State<AlertDialogOne> createState() => _AlertDialogOneState();
}

class _AlertDialogOneState extends State<AlertDialogOne> {
   InterstitialAd? _interstitialAd;

    @override
   void didChangeDependencies() {
    super.didChangeDependencies();
    _createInterstitialAd(); 
  }
  
  @override
  void initState() {
    super.initState();
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
 

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      
          shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(20.0)
              ),

          title: Text("Do you want to access camera?",
          style: GoogleFonts.lato(fontSize: 22),
          ),
          content: Text("Phone Camera 📷",
           style: GoogleFonts.lato(fontSize: 14),
          ),

          actions: <Widget>[


            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: MaterialButton(
                shape: const StadiumBorder(),
                minWidth: 100,
                color: Colors.blue,
                child: const Text("Yes"),
                onPressed: () {
                    
                       pickImage(source: ImageSource.camera).then((value) {
                          if(value != '') {
                        imageCropperView(value, context).then((value) {
                            if (value != '') {
                               Navigator.pushReplacement(
                            context,
                            CupertinoPageRoute(
                            builder: (_) => RecognizePage(
                              
                             path: value,
                           
                           ),
                      ),
                    );
                            }
                        });
                          
                  }
                       });                },
              ),
            ),

            MaterialButton(
              shape: const StadiumBorder(),
              minWidth: 100,
              color: Colors.red,
              child: const Text("cancel"),
              onPressed: () {
                Navigator.of(context).pop();
                 _showInterstitialAd();
              },
            ),

          ],
        );
      }
  }


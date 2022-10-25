// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdState {
  Future<InitializationStatus> initialization;

  AdState(this.initialization);

 static String? get bannerAdUnitId {
    if(Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    }
    return null;
}
 
 static final BannerAdListener bannerAdListener = BannerAdListener(
  
  onAdLoaded: (ad) => debugPrint('Ad loaded.'),
  onAdFailedToLoad: (ad, error){
     ad.dispose();
     debugPrint('Ad failed to load : $error');
  },
  onAdOpened: (ad) => debugPrint('Ad opened'),
  onAdClosed: (ad) => debugPrint('Ad closed'),
 );

}

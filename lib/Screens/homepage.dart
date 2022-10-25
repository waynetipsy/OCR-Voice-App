
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ocr_voice_app/Model/ad_state.dart';
import 'package:provider/provider.dart';
import '../provider/theme.provider.dart';
import 'package:ocr_voice_app/Screens/pdfmaker.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:ocr_voice_app/Screens/readnote.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';
import '../Widgets/alertdialogone.dart';
import '../Widgets/alertdialogtwo.dart';
import '../Screens/appdrawer.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future showToast(String message) async{
  await Fluttertoast.cancel();

  Fluttertoast.showToast(msg: message, fontSize: 18);
  }

  BannerAd?  banner;
  //bool _bannerIsLoaded = false;

 @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adState = Provider.of<AdState>(context);
    adState.initialization.then((status) {
      setState(() {
        banner = BannerAd( 
      size: AdSize.fullBanner, 
      adUnitId:  AdState.bannerAdUnitId!,
      listener: AdState.bannerAdListener,
      request: const AdRequest(),
       )..load();

       //_bannerIsLoaded = true;
      }
      );
      } 
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
       
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        
        ),
        
      
      drawer: const AppDrawer(),

     /* floatingActionButton: 
        SpeedDial(
         animatedIcon: AnimatedIcons.menu_close,
         backgroundColor: Colors.black,
         icon: Icons.home,
         overlayColor: Colors.black,
         overlayOpacity: 0.4,
         spacing: 20,
         spaceBetweenChildren: 12,
         //closeManually: true,
         children: [
          SpeedDialChild(
            child: const Icon(Icons.share),
            elevation: 30,
            labelWidget: labelDesign(Colors.green, 'Share App'),
            backgroundColor: Colors.green,
            onTap: () {
                Share.share(TextHelper.appUrl);
            },
          
           ),
            SpeedDialChild(
            child: const Icon(Icons.logout),
            backgroundColor: Colors.amberAccent,
            onTap: () {
              SystemNavigator.pop();
            },
            labelWidget: labelDesign(Colors.blue, 'Close App'),
            labelBackgroundColor: Colors.amber,
            
            )
          ],
        ),  */
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Card(
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
                  children:const [
                    Text('Hello...😊😉 ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16,
                      )
                    ),
                    SizedBox(height: 10),
                     Text('What feature do you want to use today?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                      )
                    ),
                  ],

                    ),
                  )
                ),
               const SizedBox(height: 30),
               Expanded(
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  children: [
                    GestureDetector(
                      onTap: () {
                      Navigator.of(context).
                      pushReplacementNamed('pdf');

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
                          children: const [
                            Icon(Icons.file_copy,
                            color: Colors.white,
                            size: 65,
                            ),
                      SizedBox(height: 15,),
                            Text("Picture to Pdf",
                        style: TextStyle(color: Colors.white,
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
                          children: const [
                            Icon(CupertinoIcons.camera,
                            color: Colors.white,
                            size: 65,
                            ),
                      SizedBox(height: 15,),
                            Text("Camera to Text ",
                        style: TextStyle(color: Colors.white,
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
                            children: const [
                              Icon(Icons.image,
                              color: Colors.white,
                              size: 65,
                              ),
                        SizedBox(height: 15,),
                              Text("Image to Text ",
                          style: TextStyle(color: Colors.white,
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
                          Navigator.of(context).pushReplacementNamed('read');
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
                            children: const [
                              Icon(Icons.file_copy,
                              color: Colors.white,
                              size: 65,
                              ),
                             SizedBox(height: 15,),
                              Text("Text to Sound",
                          style: TextStyle(color: Colors.white,
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
        bottomNavigationBar: banner == null
        ? Container()
        : Container(
          margin: const EdgeInsets.only(bottom: 12),
          height: 50,
          child: AdWidget(ad: banner!),
        )
    );
          
  }
}
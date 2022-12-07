import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ocr_voice_app/Model/ad_state.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import  '../Model/data_model.dart';
import 'package:ocr_voice_app/Model/database.dart';

class SavedText extends StatefulWidget {
   SavedText({Key? key}) : super(key: key);


  @override
  State<SavedText> createState() => _SavedTextState();
}

class _SavedTextState extends State<SavedText> {

   InterstitialAd? _interstitialAd;
   DBHelper? dbHelper;
   late Future<List<NoteModel>> dataList;

    @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _createInterstitialAd(); 
  }
  
  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    loadData();
  }
  loadData()async {
    dataList = dbHelper!.getDataList();
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Saved Text',
        style: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
          fontSize: 17,
          ),
        ),
      ),
      body:  Column(
       children: [
        Expanded(
          child: FutureBuilder(
            future: dataList,
            builder: (context, AsyncSnapshot<List<NoteModel>> snapshot) {
             if(!snapshot.hasData || snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator()
                );
              
             } 
             else if (snapshot.data!.length == 0) {
             return Center(
              child: Text('No text found',
             style: TextStyle(fontSize: 22,
             fontWeight: FontWeight.bold,
                 ),
                ),
              );
             } else {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  int noteId = snapshot.data![index].id!.toInt();
                  String noteTitle = snapshot.data![index].title.toString();
                  String noteDesc = snapshot.data![index].desc.toString();
                  String noteDT =
                   snapshot.data![index].dateandtime.toString();
                  return  InkWell(
                    onTap: () {
                     _showInterstitialAd();  
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Container(
                          margin: EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            boxShadow: [BoxShadow(color: Colors.black,
                            //blurRadius: 4, spreadRadius: 1
                            )],
                            color: Colors.white
                            ),
                          child: Column(
                            children: [
                              ListTile(
                                contentPadding: EdgeInsets.all(12),
                                title: Padding(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    noteTitle, 
                                    style: GoogleFonts.lato(
                                    fontSize: 19,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold
                                  ),),
                                  ),
                                  subtitle: Text(noteDesc, 
                                  style: GoogleFonts.roboto(
                                    fontSize: 15,
                                    color: Colors.grey.shade800,
                                    fontWeight: FontWeight.bold
                                  ),),
                              ),
                              Divider(color: Colors.black,
                              thickness: 0.8,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 10
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(noteDT,
                                    
                                    style: TextStyle(fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.italic
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                    FlutterClipboard.copy(noteDesc); 
                                    Fluttertoast.showToast(msg: 'Text copied');
                                    },
                                    icon: Icon(Icons.content_copy,
                                    color: Colors.blue,
                                    ),
                                    iconSize: 27,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                         setState(() {
                             dbHelper!.delete(noteId);  
                             dataList = dbHelper!.getDataList();
                             snapshot.data!.remove(snapshot.data![index]);
                            Fluttertoast.showToast(msg: 'Saved text deleted');
                          }); 
                                      }, 
                                      icon: Icon(Icons.delete,
                                      color: Colors.red,
                                      ),
                                      iconSize: 27,
                                      )
                                  ],
                                ),
                                )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                    
                }
                );
             }
          })
          )
       ],
    )
      );
  }}
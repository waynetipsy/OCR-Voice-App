
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ocr_voice_app/Screens/readnote.dart';
import 'package:ocr_voice_app/Screens/recongnization_page.dart';
import 'package:ocr_voice_app/Utilis/image_crooper_page.dart';
import 'package:ocr_voice_app/Utilis/image_picker_class.dart';
import 'package:fluttertoast/fluttertoast.dart';


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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
       
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        //title: const Text("Home"),
        backgroundColor: Colors.grey[300],
        elevation: 0,
        leading: const Icon(Icons.menu,
        color: Colors.black,
        ),
        
      ),

    /*  floatingActionButton: 
        SpeedDial(
         animatedIcon: AnimatedIcons.menu_close,
         backgroundColor: Colors.black,
         icon: Icons.home,
         overlayColor: Colors.black,
         overlayOpacity: 0.4,
         spacing: 20,
         spaceBetweenChildren: 12,
         //closeManually: true,
         onOpen: () => showToast('Opened...'),
         onClose: () => showToast("Closed..."),
         children: [
          SpeedDialChild(
            child: const Icon(Icons.read_more_rounded),
            elevation: 30,
            labelWidget: labelDesign(Colors.green, 'Read Note'),
            backgroundColor: Colors.green,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ReadNote()));
            },
          
           ),
            SpeedDialChild(
            child: const Icon(Icons.voice_over_off),
            backgroundColor: Colors.amberAccent,
            onTap: () {
              
            },
            labelWidget: labelDesign(Colors.blue, 'Voice'),
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
                    height: 140,
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
                      fontSize: 25,
                      )
                    ),
                  ],

                    ),
                  )
                ),
               const SizedBox(height: 20),
               Expanded(
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  children: [
                    GestureDetector(
                      onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ReadNote()
                   )
                 );
                      },
                      child: Card(
                        shadowColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        
                        borderRadius: BorderRadius.circular(20)
                        ),
                      color: Colors.black,
                      elevation: 8,
                      child: Container(
                      padding: const EdgeInsets.all(15),
                        child: Column(
                          children: const [
                            Icon(Icons.mic,
                            color: Colors.white,
                            size: 70,
                            ),
                      SizedBox(height: 10,),
                            Text("Listen to text ",
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
                    
                       pickImage(source: ImageSource.camera).then((value) {
                          if(value != '') {
                        
                           Navigator.push(
                            context,
                            CupertinoPageRoute(
                            builder: (_) => RecognizePage(
                             path: value,
                           
                           ),
                      ),
                    );
                  }
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
                         padding: const EdgeInsets.all(15),
                        child: Column(
                          children: const [
                            Icon(Icons.camera,
                            color: Colors.white,
                            size: 70,
                            ),
                      SizedBox(height: 10,),
                            Text("camera image ",
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
                       pickImage(source: ImageSource.gallery).then((value) {
                          if(value != '') {
                        imageCropperView(value, context).then((value) {
                         if (value != '') {
                           Navigator.push(
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
                         padding: const EdgeInsets.all(15),
                          child: Column(
                            children: const [
                              Icon(Icons.image,
                              color: Colors.white,
                              size: 70,
                              ),
                        SizedBox(height: 10,),
                              Text(" Gallery Image ",
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

                          },
                          child: Card(
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                          ),
                          shadowColor: Colors.blue,
                          color: Colors.black,
                          elevation: 8,
                            child: Container(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            children: const [
                              Icon(Icons.mic,
                              color: Colors.white,
                              size: 80,
                              ),
                             SizedBox(height: 10,),
                              Text("Listen to text ",
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
              )
              ]

            )
          )
        )    
    );
          
  }
}
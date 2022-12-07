import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ocr_voice_app/Screens/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';



class NamePage extends StatefulWidget {
  const NamePage({super.key});

  @override
  State<NamePage> createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  final _name =   TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String load = 'Get Started';

   Future<void> savetext(back) async{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('text', back);
     }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.grey.shade900,
      body: SafeArea(
        child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Image.asset('assets/genie_ma.png', height: 250, width: 250,),
                  SizedBox(height: 5,),
                  Text('Text Genie',
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 36
                  ),
                  ),
                  SizedBox(height: 50,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      validator: (value) {
                       if (value == null || value.isEmpty) {
                         return 'Please enter name';
                         }
                           return null;
                                 },
                      controller: _name,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                         borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12), 
                          ),
                          hintText: 'Enter your name here',
                          
                         fillColor: Colors.grey.shade600,
                          filled: true,
                        ),
                      ),
                  ),
                 ),
                 SizedBox(height: 20),
                 
                Container(
                  padding: EdgeInsets.all(70),
                  
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      textStyle: TextStyle(fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                      ),
                      minimumSize: Size.fromHeight(50),
                      shape: StadiumBorder()
                    ),
                    onPressed: () async {
                      if(_formKey.currentState!.validate()) {
                final title = _name.value.text;
                     if(title.isEmpty ){
                       return;
                     }
                     if (_isLoading) return;
                     setState(() => _isLoading = true);
                     await Future.delayed(Duration(seconds: 5));
                      setState(() => _isLoading = false);
                         savetext(_name.text) ;
                       Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => HomePage()),
                  );
                     } },
                    child: _isLoading ?
                  Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    CircularProgressIndicator(color: Colors.blue,),
                  SizedBox(width: 24,),
                  Text('Please Wait...', 
                  style: TextStyle(color: Colors.black),
                  )
                   ]
                  )
                   : Text('Get Started', 
                   style: TextStyle(color: Colors.black),
                   )
                    ),
                )
                ],
              ),
            )
           )
            )
            );
          }
          }
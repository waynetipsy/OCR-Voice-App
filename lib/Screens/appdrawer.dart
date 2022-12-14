import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/cupertino.dart';
import '../Widgets/alertdialogthree.dart';
import '../Utilis/text.dart';
import '../Widgets/change_theme_button_widget.dart';


class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     
    return Drawer(
      elevation: 40,
    
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            height: 180,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.blue,
                
                Colors.red,
                
              ]),
            ),
            alignment: Alignment.bottomLeft,
            child:  CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/app_barpic.png'),
              backgroundColor: Colors.black,
              )
          ),
          ListTile(
            onTap: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('home', (route) => false);
            },
            title: Text(
              'Main Menu',
              style: GoogleFonts.lato(
                color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 17
              ),
            ),
            trailing: Icon(
              CupertinoIcons.home,
              color: Theme.of(context).primaryColor,
            ),
          ),
          ListTile(
            onTap: () {
              
            },
            title:  Text(
              'App Theme',
              style: GoogleFonts.lato(
                color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 17),
            ),
            trailing: const ChangeThemeButtonWidgets()
          ),
          ListTile(
            onTap: () {
              Share.share(TextHelper.appUrl);
            },
            title: Text(
              'Share App',
              style:  GoogleFonts.lato(
                color:  Theme.of(context).primaryColor,
              fontSize: 17,
               fontWeight: FontWeight.bold),
            ),
            trailing: Icon(
              CupertinoIcons.share,
              color: Theme.of(context).primaryColor,
            ),
          ),
          ListTile(
            onTap: () {
                
                showDialog(
                  barrierDismissible: false,
                  context: context,
                   builder: (context) => const AlertDialogThree()
                   );
                   
                  
            },
            title: Text(
              'Close App',
              style: GoogleFonts.lato(
                color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
               fontSize: 17
               ),
            ),
            trailing: Icon(
              Icons.logout_rounded,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
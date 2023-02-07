import 'package:flutter/material.dart';
import 'package:khulasa/Views/NavBar/Toggle.dart';
import 'package:khulasa/Views/Saved/saved.dart';
import 'package:khulasa/constants/colors.dart';
import 'package:khulasa/Controllers/navigation.dart';
import 'package:khulasa/constants/sizes.dart';

class Draw extends StatefulWidget {
  const Draw({super.key});

  @override
  State<Draw> createState() => _DrawState();
}

class _DrawState extends State<Draw> {
  @override
  Widget build(BuildContext context) {
   return Drawer(
  //  Scaffold(
  //   appBar: AppBar(
    
  //   backgroundColor: background,
  //   ),
   
      backgroundColor: primary,
      width: screenWidth/3 + 11,
      child: ListView(
        // Important: Remove any padding from the ListView.
       padding: const EdgeInsets.all(10,),
       
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: primary,
            ),
            child: ToggleButton(),
            //toggle button here
          ),
          ListTile(
            title: const Text('RSS feed',
            style: TextStyle(
            fontSize: buttonFont,
            color: text,)
      ),

            onTap: () {
              Navigator.pop(context);
            },
          ),

          ListTile(
            title: const Text('Summary',
             style: TextStyle(
            fontSize: buttonFont,
            color: text,)  
          ),
            onTap: () {
            },
          ),
           ListTile(
            title: const Text('Saved',
             style: TextStyle(
            fontSize: buttonFont,
            color: text,)),
            onTap: () {
             Navigation().navigationReplace(context, const Saved());
            },
          ),
          ListTile(
            title: const Text('Settings',
             style: TextStyle(
            fontSize: buttonFont,
            color: text,)),
      
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Padding(padding:  EdgeInsets.only(top: screenHeight/3),
          child: 
          ListTile(
            title: const Text('Logout',
             style: TextStyle(
            fontSize: buttonFont,
            color: secondary,)),
      
            onTap: () {
              Navigator.pop(context);
            },
          ),),
        ],
      ),
    
    
  );
  }
}

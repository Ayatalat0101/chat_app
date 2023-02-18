

import 'package:flutter/material.dart';
import 'package:try_app/screens/helper/constant.dart';

import '../signInScreens/screens/user_info.dart';
import 'ContactsChat.dart';
import 'contact_screen.dart';

class MainScreen extends StatefulWidget {
  static const route="/main";
   MainScreen({Key? key, this.ZrawerController}) : super(key: key);
  final ZrawerController;
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
   int currentIndex=0;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      drawer:UserInformationScreen(),
      backgroundColor:Colors.white,
      bottomNavigationBar:BottomNavigationBar(
        onTap: (index){
          setState(() {
            currentIndex=index;
          });

        },
        currentIndex:currentIndex,
        selectedFontSize:14,
        unselectedFontSize:12,
        selectedItemColor:AppColors.kHotPinkColor,
        items: [
          BottomNavigationBarItem(icon:Icon(Icons.chat_bubble),
          label: "chat"
          ),
          BottomNavigationBarItem(icon:Icon(Icons.contacts),
              label: "contact"
          )
        ],

      ),
      body:screens[currentIndex]
             ) ;
  }

  List<Widget> screens=[
    ContactsChats(),
       ContactScreen(),
  ];
}

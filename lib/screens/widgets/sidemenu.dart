
import 'package:flutter/material.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});
  static const route="/side_menu";
  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Container(
          width: 288,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.pink,
          ),
          child: DefaultTextStyle(
            style: const TextStyle(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 24, top: 40, bottom: 16),
                  child: TextButton(
                    onPressed: () {
                      //todo:signOut();
                    },
                    child:Row(
                      children: [
                        Icon(Icons.logout,color:Colors.white,),
                        SizedBox(width:5,),
                        Text( "Sign out".toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Colors.white70),),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    ) ;
  }
}


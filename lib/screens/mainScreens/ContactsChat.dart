

import 'package:flutter/material.dart';
import '../widgets/chatCard.dart';

class ContactsChats extends StatelessWidget {
  ContactsChats({Key? key}) : super(key: key);
  List conversations=[];
  @override
  Widget build(BuildContext context) {
    return conversations.length==0? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/Authentication.png'),
        ],
      ):Expanded(
        child:ListView.builder(
            itemBuilder:(context,index)=>ChatCard(),
          itemCount: conversations.length,
        )
    );
  }
}

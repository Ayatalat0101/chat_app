


import 'package:flutter/material.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color:Colors.black54,
      child:ListTile(
        title:Text("Contact name"),
        subtitle:Text("Last massage at chat"),
      ),
    );
  }
}

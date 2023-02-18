


import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors{
  static const  Color kPinkColor=Color(0xfff95c5c);
  static const Color kWhiteColor=Color(0xfff8f7f7);
  static const Color kGrayColor=Color(0xff3d3d3a);
  static const Color kHotPinkColor=Color(0xfff72225);
  static const Color kltilePinkColor=Color(0xffe7a4b6);
}

 TextStyle ksubStyle=TextStyle(
   color:Colors.black,
   fontSize:18,
   fontWeight:FontWeight.normal
 );
TextStyle kmainStyle=TextStyle(
    color:Colors.black,
    fontSize:20,
    fontWeight:FontWeight.w700
);
const kSendButtonTextStyle = TextStyle(
  color:AppColors.kPinkColor,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);
const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color:AppColors.kltilePinkColor, width: 2.0),
  ),
);

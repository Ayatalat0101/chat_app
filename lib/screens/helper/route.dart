import 'package:flutter/material.dart';
import 'package:try_app/screens/mainScreens/contact_screen.dart';
import 'package:try_app/screens/mainScreens/mainScreen.dart';
import 'package:try_app/screens/signInScreens/screens/otp_screen.dart';
import 'package:try_app/screens/signInScreens/screens/signin_screen.dart';
import 'package:try_app/screens/signInScreens/screens/splash_screen.dart';

import '../mainScreens/chat_screen.dart';
import '../mainScreens/navigationScreen.dart';


class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplachScreen.route:
        return MaterialPageRoute(
          builder: (_) => SplachScreen()
        );

      case LoginScreen.route:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),

        );

      case MainScreen.route:
        return MaterialPageRoute(
          builder: (_) =>  MainScreen(),

        );
      case ContactScreen.route:
        return MaterialPageRoute(
          builder: (_) =>  ContactScreen (),

        );
      case  NotificationsScreen.route:
        return MaterialPageRoute(
          builder: (_) =>NotificationsScreen(),

        );
      case  OtpScreen.route:
       // final phoneNumber = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => OtpScreen(),
        );
      case   ChatScreen.route:
      // final phoneNumber = settings.arguments;
        return MaterialPageRoute(
          builder: (_) =>  ChatScreen(),
        );
    }
  }
}
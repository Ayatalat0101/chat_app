import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:try_app/screens/helper/firebase_options.dart';
import 'package:try_app/screens/helper/route.dart';
import 'package:try_app/screens/signInScreens/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {

  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

String? fcmToken;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  print('User granted permission: ${settings.authorizationStatus}');

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FirebaseMessaging.instance.subscribeToTopic("breaking_news");
  runApp( const ProviderScope(child: MyApp()));
}

class MyApp extends  ConsumerWidget {
  void getFcm() async {
    fcmToken = await FirebaseMessaging.instance.getToken();
    print('fcm token: $fcmToken');
  }
  static AppRouter appRouter= AppRouter();
  const MyApp({super.key});
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    getFcm();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute:appRouter.generateRoute,
      title: 'Flutter Demo',
       initialRoute:SplachScreen.route,
    );
  }
}



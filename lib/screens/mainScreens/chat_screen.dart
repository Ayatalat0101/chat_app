

import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:googleapis_auth/auth.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import '../helper/constant.dart';
import '../signInScreens/screens/signin_screen.dart';
import 'navigationScreen.dart';

class ChatScreen extends StatefulWidget {
  static const route = 'ChatScreen';
  final  String ?concatName;

  const ChatScreen({super.key, this.concatName});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
  String? typingId;
  // dynamic messages;
  Timer? _timer;
  late User user;
  TextEditingController controller = TextEditingController();
  List<RemoteNotification?> notifications = [];
  String token = '';

  void getCurrentUser() {
    user = _auth.currentUser!;
    print(user.phoneNumber);
  }

  // void getMessages() async {
  //   messages = await _fireStore.collection('messages').get();
  //   setState(() {});
  //   for (var item in messages.docs) {
  //     print(item['text']);
  //   }
  // }

  void getNotifications() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        setState(() {
          notifications.add(message.notification);
        });
        print(
            'Message also contained a notification: ${message.notification!.title}');
      }
    });
  }

  Future<AccessToken> getAccessToken() async {
    final serviceAccount = await rootBundle.loadString(
        'assets/chat-app-c6b60-firebase-adminsdk-w1x0d-87facad419.json');
    final data = await json.decode(serviceAccount);
    print(data);
    final accountCredentials = ServiceAccountCredentials.fromJson({
      "private_key_id": data['private_key_id'],
      "private_key": data['private_key'],
      "client_email": data['client_email'],
      "client_id": data['client_id'],
      "type": data['type'],
    });
    final scopes = ["https://www.googleapis.com/auth/firebase.messaging"];
    final AuthClient authclient = await clientViaServiceAccount(
      accountCredentials,
      scopes,
    )
      ..close(); // Remember to close the client when you are finished with it.

    print(authclient.credentials.accessToken);

    return authclient.credentials.accessToken;
  }

  void sendNotification(String title, String body) async {
    http.Response response = await http.post(
      Uri.parse(
          'https://fcm.googleapis.com/v1/projects/chat-app-c6b60/messages:send'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        "message": {
          "topic": "breaking_news",
          // "token": fcmToken,
          "notification": {"body": body, "title": title}
        }
      }),
    );
    print('response.body: ${response.body}');
  }

  @override
  void initState() {
    getCurrentUser();
    getNotifications();
    getAccessToken().then((value) => token = value.data);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:AppColors.kHotPinkColor,
        leading: null,
        actions: <Widget>[
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
                  Navigator.pushNamed(context, NotificationsScreen.route,
                      arguments: notifications)
                      .then(
                        (value) => setState(() {
                      notifications.clear();
                    }),
                  );
                },
              ),
              notifications.isNotEmpty
                  ? Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 2,
                ),
                decoration: const BoxDecoration(
                    color: Colors.red, shape: BoxShape.circle),
                child: Text(
                  '${notifications.length}',
                  style: const TextStyle(fontSize: 10),
                ),
              )
                  : const SizedBox(),
            ],
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _auth.signOut();
              Navigator.pushNamedAndRemoveUntil(
                  context, LoginScreen.route, (route) => false);
            },
          ),
        ],
        title: Text('⚡️Chat'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            /*StreamBuilder(
                stream: _fireStore.collection('typing_users').snapshots(),
                builder: (context, snapShot) {
                  if (snapShot.hasData) {
                    List<dynamic> users = snapShot.data!.docs;
                    return ListView.builder(
                        reverse: true,
                        shrinkWrap: true,
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          if (users[index]['user'] != user.phoneNumber) {
                            return Container(
                                color: Colors.amberAccent,
                                child: Text('${users[index]['user']}'));
                          }
                          return SizedBox();
                        });
                  }
                  return const SizedBox();
                }),*/
            SizedBox(
              height: 24,
            ),
            StreamBuilder(
                stream: _fireStore
                    .collection('messages').doc("doc_id")
                    .collection('${widget.concatName}')
                    .orderBy('time', descending: true)
                    .snapshots(),
                builder: (context, snapShot) {
                  if (snapShot.hasData) {
                    List<dynamic> messages = snapShot.data!.docs;

                    return Expanded(
                      child: ListView.builder(
                          reverse: true,
                          shrinkWrap: true,
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            return MessageBubble(
                                messages: messages,
                                index: index,
                                sender: messages[index]['sender'],
                                isMe: messages[index]['sender'] == user.phoneNumber);
                          }),
                    );
                  }
                  return Text('loading data ..');
                }),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: kMessageTextFieldDecoration,
                      onChanged: (value) async {
                        if (_timer?.isActive ?? false) _timer?.cancel();
                        _timer =
                            Timer(const Duration(milliseconds: 500), () async {
                              if (value.isNotEmpty) {
                                if (typingId == null) {
                                  final ref = await _fireStore
                                      .collection('typing_users')
                                      .add({'user': user.phoneNumber});
                                  typingId = ref.id;
                                }
                              } else if (controller.text.isEmpty) {
                                _fireStore
                                    .collection('typing_users')
                                    .doc(typingId)
                                    .delete();
                                typingId = null;
                              }
                            });
                      },
                    ),
                  ),//messages//
        // /*  'text': controller.text,
              //    'sender': user.phoneNumber,
               //   'time': DateTime.now(),*/
                  TextButton(
                    onPressed: () {
                      //Implement send functionality.
                      if (controller.text.isNotEmpty) {
                        _fireStore.collection('messages')
                            .doc("doc_id")
                            .collection('${widget.concatName}')
                            .doc()
                            .set({
                              'text': controller.text,
                              'sender': user.phoneNumber,
                            'time': DateTime.now()
                            }
                        );
                        sendNotification(
                            'message from ${user.email}', controller.text);
                        controller.clear();
                        if (typingId != null) {
                          _fireStore
                              .collection('typing_users')
                              .doc(typingId)
                              .delete();
                          typingId = null;
                        }
                      }
                    },

                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {Key? key,
        required this.messages,
        required this.index,
        required this.sender,
        required this.isMe})
      : super(key: key);

  final List messages;
  final int index;
  final String sender;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
        isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Text(
            '$sender',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Material(
            color: isMe ? AppColors.kPinkColor :AppColors.kltilePinkColor,
            borderRadius: isMe
                ? BorderRadius.only(
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            )
                : BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${messages[index]['text']}',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
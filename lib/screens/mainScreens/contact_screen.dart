import 'package:flutter/material.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:try_app/screens/mainScreens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:try_app/screens/signInScreens/controller/auth_controller.dart';
import '../helper/constant.dart';
import 'package:cloud_functions/cloud_functions.dart';
class ContactScreen extends ConsumerWidget {
  static const route="/contact_screen";
  ContactScreen({Key? key}) : super(key: key);
  final _auth = FirebaseAuth.instance;
  FirebaseFunctions functions = FirebaseFunctions.instance;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
       appBar: AppBar(
         backgroundColor:AppColors.kHotPinkColor,
          title: Text('⚡️Chat',textAlign: TextAlign.center,),
        ),
      body: SafeArea(child:Container(child: FutureBuilder(
        future:getContants(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              color:AppColors.kPinkColor,
            ),
          );
        }
        else if (snapshot.hasError) {
          print(snapshot.error);
        }
        print("data loaded");
        return   ListView.builder(
          shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              Contact contact = snapshot.data[index];
              return  Card(
                elevation:2,
                child: ListTile(
                    leading:CircleAvatar(
                      foregroundColor:AppColors.kGrayColor,
                      radius:40,
                      child:Icon(Icons.person,size:50,),
                    ) ,
                    title: Text(contact.displayName),
                   trailing:ElevatedButton(onPressed:(){
                    ref.watch(authControllerProvider).selectContact(contact,context);
                   }, child: Text("Call"),
                     style:ButtonStyle(
                         backgroundColor:MaterialStateProperty.all(
                           AppColors.kltilePinkColor,
                         )
                     ),

                )
                  ),
              );
            },
            );
      })),
      ),
    );
  }
  Future<List<Contact>> getContants()async{
    bool isGranted= await Permission.contacts.status.isGranted;
    if(! isGranted)  isGranted= await Permission.contacts.request().isGranted;
    if(!isGranted) return [];
    List<Contact> contacts = await FastContacts.getAllContacts(); // Add this line
    if(contacts.length == 0) return []; // Add this line
    return contacts;
  }


}

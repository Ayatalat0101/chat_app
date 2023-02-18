import 'dart:async';
import 'dart:io';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:try_app/screens/mainScreens/chat_screen.dart';
import '../../../models/user_model.dart';
import '../../helper/component/common_firebase_storage_repository.dart';
import '../../helper/component/utils.dart';
import '../../mainScreens/mainScreen.dart';
import '../screens/signin_screen.dart';

final authRepositoryProvider = Provider(
      (ref) => AuthRepository(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  ),
);


class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  AuthRepository({
    required this.auth,
    required this.firestore,
  });

  User ? getCurrentUser(){
    return auth.currentUser;
  }

  Future otpConfirm(smsCode,context)async{
    try{
      PhoneAuthCredential credential = PhoneAuthProvider.
      credential(verificationId:LoginScreen.verify, smsCode: smsCode);
      await auth.signInWithCredential(credential);
      Navigator.pushNamedAndRemoveUntil(context,MainScreen.route, (route) => false);
    }catch (e){
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content:Text("$e")
          )
      );

    }
  }
  Future getVerifyCode(String phoneNumber) async {
     await auth.verifyPhoneNumber(
      phoneNumber: '+970$phoneNumber',
      codeSent: (String verificationId, int? resendToken) async {
        LoginScreen.verify=verificationId;
      },
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {  },
      verificationFailed: (FirebaseAuthException error) {  },
      codeAutoRetrievalTimeout: (String verificationId) {  },
    );
  }

  Future<UserModel?> getCurrentUserData() async {
    var userData =
    await firestore.collection('users').doc(auth.currentUser?.uid).get();
    print(auth.currentUser?.uid);
    print(userData);
    UserModel? user;
    if (userData.data() != null) {
      user = UserModel.fromMap(userData.data()!);
    }
    return user;
  }
  void saveUserDataToFirebase({
    required String name,
    required File? profilePic,
    required ProviderRef ref,
    required BuildContext context,
  }) async {
    try {
      String uid = auth.currentUser!.uid;
      String photoUrl =
          'https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png';

      if (profilePic != null) {
        photoUrl = await ref
            .read(commonFirebaseStorageRepositoryProvider)
            .storeFileToFirebase(
          'profilePic/$uid',
          profilePic,
        );
      }
      var user = UserModel(
        name: name,
        uid: uid,
        profilePic: photoUrl,
        isOnline: true,
        phoneNumber: auth.currentUser!.phoneNumber!,
        groupId: [],
      );

      await firestore.collection('users').doc(uid).set(user.toMap());

      Navigator.of(context).pop();
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  Stream<UserModel> userData(String userId) {
    return firestore.collection('users').doc(userId).snapshots().map(
          (event) => UserModel.fromMap(
        event.data()!,
      ),
    );
  }

  void setUserState(bool isOnline) async {
    await firestore.collection('users').doc(auth.currentUser!.uid).update({
      'isOnline': isOnline,
    });
  }

   checkUserRegistration(phoneNumber)async{
    var user;
       var users = await  firestore.collection('users').get();
         for (var item in  users.docs) {
          print(item['phoneNumber']);
          user=item['phoneNumber'];
         }
         if(user==phoneNumber) return true;
         else return false;
   }

  void selectContact(Contact selectedContact, BuildContext context) async {
    try {
      var userCollection = await firestore.collection('users').get();
      bool isFound = false;

      for (var document in userCollection.docs) {
        var userData = UserModel.fromMap(document.data());
        String selectedPhoneNum = selectedContact.phones[0].number.replaceAll(
          ' ',
          '',
        );
        if (selectedPhoneNum == userData.phoneNumber) {
          isFound = true;
          Navigator.pushNamed(
            context,
                ChatScreen.route,
            arguments: {
              'name': userData.name,
              'uid': userData.uid,
            },
          );
        }
      }

      if (!isFound) {
        showSnackBar(
          context: context,
          content: 'This number does not exist on this app.',
        );
      }
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

}

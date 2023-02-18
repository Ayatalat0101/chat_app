import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/user_model.dart';
import '../repostitory/auth_repositry.dart';
import 'package:fast_contacts/fast_contacts.dart';
final authControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(authRepository: authRepository, ref: ref);
});

final userDataAuthProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider);
  return authController.getUserData();
});

class AuthController {
  final AuthRepository authRepository;
  final ProviderRef ref;
  AuthController({
    required this.authRepository,
    required this.ref,
  });


   getUser(){
     var user=authRepository.getCurrentUser();
    return user!.phoneNumber;
  }


  Future getCodeConfirm(String code,context)async{
     authRepository.otpConfirm(code , context);
  }
  Future getVerifiedCode( String phoneNumber)  async{
     authRepository.getVerifyCode(phoneNumber );
  }
  Future<UserModel?> getUserData() async {
    UserModel? user = await authRepository.getCurrentUserData();
    return user;
  }


  void saveUserDataToFirebase(
      BuildContext context, String name, File? profilePic)
  {
    authRepository.saveUserDataToFirebase(
      name: name,
      profilePic: profilePic,
      ref: ref,
      context: context,
    );
  }

  Stream<UserModel> userDataById(String userId) {
    return authRepository.userData(userId);
  }

  void setUserState(bool isOnline) {
    authRepository.setUserState(isOnline);
  }


  checkUserRegistration(phoneNumber){
     authRepository.checkUserRegistration(phoneNumber);
  }
  void selectContact(Contact selectedContact, BuildContext context) {
     authRepository.selectContact(selectedContact, context);
  }
}

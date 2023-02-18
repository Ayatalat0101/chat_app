import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:try_app/screens/mainScreens/mainScreen.dart';
import 'package:try_app/screens/signInScreens/screens/signin_screen.dart';
import '../../helper/constant.dart';
import '../repostitory/auth_repositry.dart';

class SplachScreen extends ConsumerWidget {
  static const route = "/splachScreen";
  SplachScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        children: [
          Spacer(),
          Column(
            children: [
              Center(
                child: Container(
                  padding: EdgeInsets.all(5),
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: AppColors.kltilePinkColor, width: 1),
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.kPinkColor, width: 2),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: AppColors.kHotPinkColor,
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          'assets/images/Chat-256.png',
                          scale: 4,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Welcome to",
                style: ksubStyle,
              ),
              SizedBox(
                height: 10,
              ),
              Text("PARADISE",
                  style: kmainStyle,
                  textHeightBehavior: TextHeightBehavior(),
                  textScaleFactor: 1.5),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.all(5),
                  width: 50,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.kHotPinkColor,
                    shape: BoxShape.rectangle,
                  ),
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Container(
                width: 50,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.kPinkColor,
                  shape: BoxShape.rectangle,
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Center(
                child: Container(
                  width: 50,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.kltilePinkColor,
                    shape: BoxShape.rectangle,
                  ),
                ),
              ),
            ],
          ),
          Spacer(),
          Material(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 20,
            child: MaterialButton(
              minWidth: double.infinity,
              elevation: 5,
              onPressed: () {
                ref.watch(authRepositoryProvider).getCurrentUser() == null
                    ? Navigator.pushNamed(context, LoginScreen.route)
                    : Navigator.pushNamedAndRemoveUntil(
                        context, MainScreen.route, (route) => false);
              },
              child: Text(
                  ref.watch(authRepositoryProvider).getCurrentUser() == null
                      ? "Sign in"
                      : "Get Start",
                  style: kmainStyle),
            ),
          )
        ],
      ),
    );
  }
}

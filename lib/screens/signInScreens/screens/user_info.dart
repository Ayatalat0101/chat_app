
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../helper/component/utils.dart';
import '../controller/auth_controller.dart';


class UserInformationScreen extends ConsumerStatefulWidget {
  static const String route= '/user-information';
  const UserInformationScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<UserInformationScreen> createState() =>
      _UserInformationScreenState();
}

class _UserInformationScreenState extends ConsumerState<UserInformationScreen> {
  final TextEditingController nameController = TextEditingController();
  File? image;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }

  void selectImage() async {
    image = await pickImageFromGallery(context);
    setState(() {});
  }

  void storeUserData() async {
    String name = nameController.text.trim();

    if (name.isNotEmpty) {
      ref.read(authControllerProvider).saveUserDataToFirebase(
        context,
        name,
        image,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return   SafeArea(
        child: Container(
          color:Colors.white,
          width:size.width*0.75,
          child: Center(
            child: Column(
              children: [
                Stack(
                  children: [
                    image == null
                        ? const CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png',
                      ),
                      radius: 64,
                    )
                        : CircleAvatar(
                      backgroundImage: FileImage(
                        image!,
                      ),
                      radius: 64,
                    ),
                    Positioned(
                      bottom: -10,
                      left: 80,
                      child: IconButton(
                        onPressed: selectImage,
                        icon: const Icon(
                          Icons.add_a_photo,
                        ),
                      ),
                    ),
                  ],
                ),
                 Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: size.width * 0.6,
                            padding: const EdgeInsets.all(20),
                            child: TextField(
                              controller: nameController,
                              decoration: const InputDecoration(
                                hintText: 'Enter your name',
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: storeUserData,
                            icon: const Icon(
                              Icons.done,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height:size.height*0.05,),
                      Container(
                        height:size.height*0.1,
                        width: size.width * 0.6,
                        padding: const EdgeInsets.all(20),
                        child:  Card(
                          elevation:10,
                          child:Center(child: Text(ref.watch(authControllerProvider).getUser().toString(),textAlign:TextAlign.center, )),
                        ),
                      ),

                    ],
                  ),
                ),
                    ],
                  ),

          ),
        ),
    );
  }
}

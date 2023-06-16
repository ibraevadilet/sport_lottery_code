import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sport_lottery/core/constants/app_text_constants.dart';
import 'package:sport_lottery/core/functions/upload_image_func.dart';
import 'package:sport_lottery/widgets/custom_app_bar.dart';
import 'package:sport_lottery/widgets/custom_button.dart';
import 'package:sport_lottery/widgets/custom_text_field.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({
    super.key,
    required this.image,
    required this.name,
  });
  final String image;
  final String name;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool isLoading = false;
  late final TextEditingController nameController =
      TextEditingController(text: widget.name);
  late String image = widget.image;
  late String name = widget.name;

  bool isEdited() => name != widget.name || image != widget.image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Редактирование профиля'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              InkWell(
                onTap: () async {
                  final ImagePicker picker = ImagePicker();
                  final XFile? imageFile = await picker.pickImage(
                    source: ImageSource.gallery,
                  );
                  if (imageFile != null) {
                    setState(
                      () {
                        image = imageFile.path;
                      },
                    );
                  }
                },
                child: image != widget.image
                    ? Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: FileImage(
                              File(image),
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : CachedNetworkImage(
                        imageUrl: image,
                        placeholder: (_, url) {
                          return Container(
                            height: 100,
                            width: 100,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey.withOpacity(0.4),
                              highlightColor: Colors.white,
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.grey,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          );
                        },
                        imageBuilder: (_, imageProvider) {
                          return Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                  image,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
              ),
              const SizedBox(height: 18),
              CustomTextField(
                controller: nameController,
                onChanged: (nameFrom) {
                  setState(() {
                    name = nameFrom;
                  });
                },
                hintText: 'Имя',
              ),
              const Spacer(),
              Visibility(
                visible: isEdited(),
                child: CustomButton(
                  isLoading: isLoading,
                  color: const Color(0xFF12B403),
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    CollectionReference firestore =
                        FirebaseFirestore.instance.collection('users');
                    setState(() {
                      isLoading = true;
                    });
                    if (image != widget.image) {
                      final avatar = await uploadImage(File(image));

                      await firestore
                          .doc(prefs.getString(SharedKeys.uid))
                          .update({"image": avatar});

                      prefs.setString(SharedKeys.image, avatar);
                    }
                    if (name != widget.name) {
                      await firestore
                          .doc(prefs.getString(SharedKeys.uid))
                          .update({"name": name});

                      prefs.setString(SharedKeys.name, name);
                    }
                    setState(() {
                      isLoading = false;
                    });

                    Navigator.pop(context);
                  },
                  text: 'Сохранить',
                ),
              ),
              const SizedBox(height: 12),
              Visibility(
                visible: isEdited() && !isLoading,
                child: CustomButton(
                  onPressed: () {
                    setState(() {
                      image = widget.image;
                      name = widget.name;
                      nameController.text = widget.name;
                    });
                  },
                  text: 'Отмена',
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

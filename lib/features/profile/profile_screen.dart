import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sport_lottery/features/auth/presentation/select_role_screen.dart';
import 'package:sport_lottery/features/profile/about_programm_screen.dart';
import 'package:sport_lottery/features/profile/edit_profile_screen.dart';
import 'package:sport_lottery/features/profile/widgets/profile_widget.dart';
import 'package:sport_lottery/helpers/app_text_styles.dart';
import 'package:sport_lottery/helpers/saved_data.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              FutureBuilder(
                future: SavedData.getImage(),
                builder: (context, image) {
                  if (image.hasData) {
                    return kIsWeb
                        ? Image.network(image.data!)
                        : CachedNetworkImage(
                            imageUrl: image.data!,
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
                                      image.data!,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          );
                  }
                  return const SizedBox();
                },
              ),
              const SizedBox(height: 18),
              FutureBuilder(
                future: SavedData.getName(),
                builder: (context, name) {
                  if (name.hasData) {
                    return Text(
                      name.data!,
                      style: AppTextStyles.s19W400(),
                    );
                  }
                  return Text(
                    '',
                    style: AppTextStyles.s19W400(),
                  );
                },
              ),
              const SizedBox(height: 5),
              FutureBuilder(
                future: SavedData.getEmail(),
                builder: (context, email) {
                  if (email.hasData) {
                    return Text(
                      email.data!,
                      style: AppTextStyles.s19W400(),
                    );
                  }
                  return Text(
                    '',
                    style: AppTextStyles.s19W400(),
                  );
                },
              ),
              const SizedBox(height: 18),
              ProfileWidget(
                title: 'Редактировать профиль',
                icon: Icons.person_2_outlined,
                onTap: () async {
                  final image = await SavedData.getImage();
                  final name = await SavedData.getName();
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfileScreen(
                        image: image,
                        name: name,
                      ),
                    ),
                  );
                  setState(
                    () {},
                  );
                },
              ),
              ProfileWidget(
                title: 'О программе',
                icon: Icons.info_outline,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AboutProgrammScreen(),
                    ),
                  );
                },
              ),
              ProfileWidget(
                title: 'Выйти',
                icon: Icons.exit_to_app,
                onTap: () async {
                  await SavedData.clear();
                  await Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SelectRoleScreen(),
                    ),
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

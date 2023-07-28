import 'package:flutter/material.dart';
import 'package:santander_app/models/user_model/user_model.dart';
import 'package:santander_app/services/api.dart';
import 'package:santander_app/shared/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:santander_app/shared/app_images.dart';
import 'package:santander_app/shared/app_settings.dart';
import 'package:santander_app/widgets/card.dart';
import 'package:santander_app/widgets/features.dart';
import 'package:santander_app/widgets/header.dart';
import 'package:santander_app/widgets/info_card.dart';

import '../../widgets/balance.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserModel? user;

  @override
  void initState() {
    super.initState();
    fetch();
  }

  fetch() async {
    user = await ApiApp.fetchUser(1);
    setState(() {
      //
    });
  }

  String replaceSpecificCharacter(String text, String character) {
    return text.replaceAll(character, 'X');
  }

  @override
  Widget build(BuildContext context) {
    return user == null
        ? const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          )
        : Scaffold(
            drawer: const Drawer(),
            appBar: AppBar(
              backgroundColor: AppColors.red,
              foregroundColor: Colors.white,
              title: SvgPicture.asset(
                AppImages.logo,
                height: 24,
              ),
              centerTitle: true,
              actions: [
                Container(
                  margin: const EdgeInsets.only(right: 16),
                  child: SvgPicture.asset(
                    AppImages.notification,
                    height: 24,
                  ),
                )
              ],
            ),
            body: Stack(
              children: [
                Column(children: [
                  HeaderWidget(
                    user: user!,
                  ),
                  const SizedBox(
                    height: 200,
                  ),
                  FeaturesWidget(features: user!.features!),
                  const SizedBox(
                    height: 10,
                  ),
                  CardWidget(card: user!.card!),
                  const SizedBox(
                    height: 10,
                  ),
                  InfoCardWidget(news: user!.news!),
                ]),
                Positioned(
                  top: (AppSettings.screenHeight / 5) - 40,
                  child: BalanceWidget(account: user!.account!),
                )
              ],
            ),
          );
  }
}

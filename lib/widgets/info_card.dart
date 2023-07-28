import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:santander_app/shared/app_colors.dart';
import 'package:santander_app/shared/app_images.dart';
import 'package:santander_app/shared/app_settings.dart';

import '../models/user_model/news.dart';

class InfoCardWidget extends StatefulWidget {
  final List<News> news;
  const InfoCardWidget({super.key, required this.news});

  @override
  State<InfoCardWidget> createState() => _InfoCardWidgetState();
}

class _InfoCardWidgetState extends State<InfoCardWidget> {
  PageController pageController = PageController();
  int cardPosition = 0;
  var icons = <Widget>[];

  @override
  void initState() {
    super.initState();
    buildIcons();
  }

  buildIcons() {
    icons.clear();
    for (var i = 0; i < widget.news.length; i++) {
      icons.add(
        Container(
          margin: const EdgeInsets.all(4),
          child: SvgPicture.asset(
            cardPosition == i ? AppImages.circleOn : AppImages.circleOff,
            height: 14,
          ),
        ),
      );
    }
  }

  Widget getFeatureCard(String image, String description) {
    return Card(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        width: AppSettings.screenWidth - 24,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 36,
            ),
            SvgPicture.network(
              image,
              semanticsLabel: '',
              colorFilter: ColorFilter.mode(AppColors.red, BlendMode.srcIn),
              width: 48,
              height: 48,
            ),
            const SizedBox(
              width: 36,
            ),
            Expanded(
              child: Text(
                description,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.grayDark),
              ),
            ),
            const SizedBox(
              width: 36,
            )
          ],
        ),
      ),
    );
  }

  String replaceSpecialCharacters(String text) {
    final Map<String, String> specialCharactersMap = {
      'Ã§': 'ç',
      'Ãª': 'ê',
      'Ãµ': 'õ',
      'Ã©': 'é',
      // Adicione outros caracteres especiais e suas correções aqui, se necessário
    };

    String result = text;
    specialCharactersMap.forEach((specialChar, replacementChar) {
      result = result.replaceAll(specialChar, replacementChar);
    });

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 100,
          width: AppSettings.screenWidth,
          child: PageView(
            onPageChanged: (index) {
              setState(() {
                cardPosition = index;
                buildIcons();
              });
            },
            controller: pageController,
            scrollDirection: Axis.horizontal,
            children: widget.news
                .map((e) => getFeatureCard(
                    e.icon!, replaceSpecialCharacters(e.description!)))
                .toList(),
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: icons),
      ],
    );
  }
}

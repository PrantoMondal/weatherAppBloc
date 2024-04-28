import 'package:flutter/material.dart';
import 'package:weather_app/utils/text_styles.dart';

buildCard({
  required double screenWidth,
  required String imageAsset,
  required String title1,
  required String content1,
  String? title2,
  String? content2,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 30),
    height: 88,
    width: screenWidth,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: const Color(0xFFFFFFFF).withOpacity(.2),
        width: 2,
      ),
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomRight,
        colors: [
          const Color(0xFFFFFFFF).withOpacity(0.3),
          const Color(0xFFFFFFFF).withOpacity(0),
        ],
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(width: 20),
        Image.asset(imageAsset),
        const SizedBox(width: 20),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title1,
              style: AppTextStyle.circularSid_400_16,
            ),
            Text(
              content1,
              style: AppTextStyle.circularSid_500_24,
            ),
          ],
        ),
        const Spacer(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              title2 ?? "",
              style: AppTextStyle.circularSid_400_16,
            ),
            Text(
              content2 ?? "",
              style: AppTextStyle.circularSid_500_24,
            ),
          ],
        ),
        const SizedBox(width: 20),
      ],
    ),
  );
}

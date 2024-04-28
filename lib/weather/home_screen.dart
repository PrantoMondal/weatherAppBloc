import 'package:flutter/material.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';
import 'package:weather_app/utils/custom_card.dart';
import 'package:weather_app/utils/text_styles.dart';
import 'package:weather_app/weather/bloc/weather_bloc.dart';

import '../utils/tab_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TabWidget? selectedItem;
  List<TabWidget> tabWidget = [
    TabWidget(tabTitle: "Today", tabWidget: const Text("Today")),
    TabWidget(tabTitle: "NextDays", tabWidget: const Text("NextDays")),
  ];

  final WeatherBloc weatherBloc = WeatherBloc();
  @override
  void initState() {
    selectedItem = tabWidget.first;
    weatherBloc.add(WeatherInitialFetchEvent());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        padding: const EdgeInsets.only(top: 50),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF97ABFF),
              Color(0xFF123597),
            ],
          ),
        ),
        child: Column(
          children: [
            Text(
              "Dhaka",
              style: AppTextStyle.inter_700_32_white,
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/location_1.png"),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  "Current Location",
                  style: AppTextStyle.circularSid_450_12,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/partly_cloudy.png",
                  height: 100,
                  width: 110,
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text("13\u00B0", style: AppTextStyle.circularSid_300_122)
              ],
            ),
            Text(
              "Partly Cloud - H:17o L:4o",
              style: AppTextStyle.circularSid_450_12.copyWith(fontSize: 18),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 55.0),
              child: Row(
                children: [
                  for (TabWidget tab in tabWidget)
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedItem = tab;
                          });
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: selectedItem == tab
                                      ? const Color(0xFFFFFFFF).withOpacity(0.1)
                                      : const Color(0xFF000000)
                                          .withOpacity(0.1),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(100),
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 32.0, vertical: 12),
                                child: Center(
                                  child: Text(
                                    tab.tabTitle,
                                    style: AppTextStyle.inter_700_32_white
                                        .copyWith(fontSize: 14),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 140,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: 40,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color(0xFFFFFFFF).withOpacity(.2),
                          width: 2),
                      borderRadius: BorderRadius.circular(100),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0xFFFFFFFF).withOpacity(.5), //A0B0E6
                          const Color(0xFFFFFFFF).withOpacity(0),
                        ],
                      ),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    height: 139,
                    width: 65,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Now",
                          style: AppTextStyle.circularSid_450_12
                              .copyWith(fontSize: 16),
                        ),
                        Image.asset(
                          "assets/images/partly_cloudy.png",
                          height: 49,
                          width: 48,
                          fit: BoxFit.cover,
                        ),
                        Text(
                          "13\u00B0",
                          style: AppTextStyle.circularSid_450_12
                              .copyWith(fontSize: 18),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Stack(
                children: [
                  ClipPath(
                    clipper: ProsteBezierCurve(
                      position: ClipPosition.top,
                      list: [
                        BezierCurveSection(
                          start: Offset(screenWidth, 60),
                          top: Offset(screenWidth / 2, 20),
                          end: const Offset(0, 60),
                        ),
                      ],
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF97ABFF),
                            Color(0xFF123597),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 45,
                          backgroundColor: const Color(0xFF4A66BF),
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xFF97ABFF),
                                  Color(0xFF123597),
                                ],
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0)
                                      .copyWith(top: 60),
                              child: Image.asset(
                                "assets/images/arrow_up.png",
                                height: 20,
                                // width: 20,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        buildCard(
                          screenWidth: screenWidth,
                          imageAsset: "assets/images/sun_rise.png",
                          title1: "Sunset",
                          content1: "5:51PM",
                          title2: "Sunrise",
                          content2: "7:00AM",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        buildCard(
                          screenWidth: screenWidth,
                          imageAsset: "assets/images/sun.png",
                          title1: "UV Index",
                          content1: "1 Low",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/utils/text_styles.dart';

class TabWidget {
  String tabTitle;
  Widget tabWidget;

  TabWidget({
    required this.tabTitle,
    required this.tabWidget,
  });
}

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
  @override
  void initState() {
    selectedItem = tabWidget.first;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
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
                  height: 130,
                  width: 135,
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  "13\u00B0",
                  style: AppTextStyle.circularSid_300_122,
                )
              ],
            ),
            Text(
              "Partly Cloud - H:17o L:4o",
              style: AppTextStyle.circularSid_450_12.copyWith(fontSize: 18),
            ),
            const SizedBox(
              height: 20,
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
          ],
        ),
      ),
    );
  }
}

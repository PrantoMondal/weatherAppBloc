import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weather_app/utils/custom_card.dart';
import 'package:weather_app/utils/text_styles.dart';
import 'package:weather_app/utils/weather_skeleton.dart';
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
  bool isMetric = true;

  final WeatherBloc weatherBloc = WeatherBloc();
  @override
  void initState() {
    selectedItem = tabWidget.first;
    weatherBloc.add(WeatherInitialFetchEvent());
    // TODO: implement initState
    super.initState();
  }

  void _toggleSwitch(bool value) {
    setState(() {
      isMetric = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: BlocConsumer<WeatherBloc, WeatherState>(
        bloc: weatherBloc,
        listenWhen: (previous, current) => current is WeatherActionState,
        buildWhen: (previous, current) => current is! WeatherActionState,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case WeatherFetchSuccessfulState:
              final successState = state as WeatherFetchSuccessfulState;
              return Container(
                height: screenHeight,
                width: screenWidth,
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
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Spacer(),
                        Text(
                          successState.weather.location.name,
                          style: AppTextStyle.inter_700_32_white,
                        ),
                        SizedBox(
                          width: screenWidth / 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            //todo Show bottom sheet
                          },
                          child: const Icon(
                            Icons.search_outlined,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Switch(
                          value: isMetric,
                          onChanged: _toggleSwitch,
                          activeTrackColor: Colors.white,
                          activeColor: const Color(0xFF97ABFF),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/location_1.png"),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          "${successState.weather.location.tzId},${successState.weather.location.country}",
                          style: AppTextStyle.circularSid_450_12,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          "https:${successState.weather.current.condition.icon}",
                          height: 100,
                          width: 110,
                          fit: BoxFit.cover,
                        ),
                        Text(
                            isMetric
                                ? "${successState.weather.current.tempC}\u00B0"
                                : "${successState.weather.current.tempF}F",
                            style: AppTextStyle.circularSid_300_122)
                      ],
                    ),
                    Text(
                      isMetric
                          ? "${successState.weather.current.condition.text} - H:${successState.weather.forecast.forecastday[0].day.maxtempC}\u00B0, L:${successState.weather.forecast.forecastday[0].day.mintempC}\u00B0"
                          : "${successState.weather.current.condition.text} - H:${successState.weather.forecast.forecastday[0].day.maxtempF}F, L:${successState.weather.forecast.forecastday[0].day.mintempF}F",
                      style: AppTextStyle.circularSid_450_12
                          .copyWith(fontSize: 18),
                    ),
                    Text(
                      isMetric
                          ? "Humidity: ${successState.weather.current.humidity}, Feels Like: ${successState.weather.current.feelsLikeC}\u00B0"
                          : "Humidity: ${successState.weather.current.humidity}, Feels Like: ${successState.weather.current.feelsLikeF}F",
                      style: AppTextStyle.circularSid_450_12
                          .copyWith(fontSize: 18),
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
                                  // todo : need to remove this setState
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
                                              ? const Color(0xFFFFFFFF)
                                                  .withOpacity(0.1)
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
                                            style: AppTextStyle
                                                .inter_700_32_white
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
                      height: 165,
                      child: selectedItem!.tabTitle == "Today"
                          ? SizedBox(
                              height: 130,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: successState.weather.forecast
                                    .forecastday[0].hour.length,
                                itemBuilder: (context, index) {
                                  return buildMiddleContainer(
                                    successState.weather.forecast.forecastday[0]
                                        .hour[index].time,
                                    successState.weather.forecast.forecastday[0]
                                        .hour[index].condition.icon,
                                    successState.weather.forecast.forecastday[0]
                                        .hour[index].tempC,
                                  );
                                },
                              ),
                            )
                          : SizedBox(
                              height: 130,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: successState
                                        .weather.forecast.forecastday.length -
                                    1,
                                itemBuilder: (context, dayIndex) {
                                  return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: successState.weather.forecast
                                        .forecastday[dayIndex + 1].hour.length,
                                    itemBuilder: (context, hourIndex) {
                                      var hour = successState
                                          .weather
                                          .forecast
                                          .forecastday[dayIndex + 1]
                                          .hour[hourIndex];
                                      return buildMiddleContainer(
                                        hour.time,
                                        hour.condition.icon,
                                        hour.tempC,
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
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
                                  top: Offset(screenWidth / 2, 25),
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
                            child: CircleAvatar(
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
                                  padding: const EdgeInsets.symmetric(
                                          horizontal: 30.0)
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
                          ),
                          Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    buildCard(
                                      screenWidth: screenWidth,
                                      imageAsset: "assets/images/sun_rise.png",
                                      title1: "Sunset",
                                      content1: successState.weather.forecast
                                          .forecastday[0].astro.sunset,
                                      title2: "Sunrise",
                                      content2: successState.weather.forecast
                                          .forecastday[0].astro.sunrise,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    buildCard(
                                        screenWidth: screenWidth,
                                        imageAsset: "assets/images/sun.png",
                                        title1: "UV Index",
                                        content1: successState.weather.forecast
                                            .forecastday[0].day.uv
                                            .toString(),
                                        title2: "Pressure",
                                        content2: isMetric
                                            ? successState
                                                .weather.current.pressureMb
                                                .toString()
                                            : successState
                                                .weather.current.pressureIn
                                                .toString()),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              );

            default:
              return const WeatherSkeleton();
          }
        },
      ),
    );
  }

  buildMiddleContainer(String time, String iconUrl, double temperature) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
                color: const Color(0xFFFFFFFF).withOpacity(.2), width: 2),
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
                DateFormat("dd hh a").format(DateTime.now()) ==
                        DateFormat("dd hh a").format(DateTime.parse(time))
                    ? "Now"
                    : DateFormat.j().format(DateTime.parse(time)),
                style: AppTextStyle.circularSid_450_12.copyWith(fontSize: 16),
              ),
              Image.network(
                "http:$iconUrl",
                height: 49,
                width: 48,
                fit: BoxFit.cover,
              ),
              Text(
                "$temperature\u00B0",
                style: AppTextStyle.circularSid_450_12.copyWith(fontSize: 18),
              ),
            ],
          ),
        ),
        DateFormat("dd hh a").format(DateTime.now()) ==
                DateFormat("dd hh a").format(DateTime.parse(time))
            ? const Padding(
                padding: EdgeInsets.only(top: 3.0),
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.white,
                ),
              )
            : const SizedBox()
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class WeatherSkeleton extends StatelessWidget {
  const WeatherSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: screenWidth,
      height: screenHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: SingleChildScrollView(
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade400,
          highlightColor: Colors.grey.shade100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              _buildContainer(30, 130, 10),
              const SizedBox(
                height: 10,
              ),
              _buildContainer(15, 240, 10),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildContainer(120, 100, 40),
                  const SizedBox(
                    width: 20,
                  ),
                  _buildContainer(120, 140, 10),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildContainer(15, 100, 10),
                  const SizedBox(
                    width: 10,
                  ),
                  _buildContainer(15, 120, 10),
                  const SizedBox(
                    width: 10,
                  ),
                  _buildContainer(15, 60, 10),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildContainer(15, 50, 10),
                  const SizedBox(
                    width: 10,
                  ),
                  _buildContainer(15, 80, 10),
                  const SizedBox(
                    width: 10,
                  ),
                  _buildContainer(15, 160, 10),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              _buildContainer(250, 500, 10),
              const SizedBox(
                height: 30,
              ),
              _buildContainer(120, 500, 10),
              const SizedBox(
                height: 10,
              ),
              _buildContainer(120, 500, 10),
            ],
          ),
        ),
      ),
    );
  }

  _buildContainer(double? height, double? width, double? radius) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(radius ?? 8)),
      width: width ?? 100,
      height: height ?? 30,
    );
  }
}

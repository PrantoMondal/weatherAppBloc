import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/utils/text_styles.dart';

import '../models/weather.dart';
import '../weather/bloc/weather_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 30,
                      )),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Search",
                    style: AppTextStyle.inter_700_32_white,
                  ),
                ],
              ),
              TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  labelText: 'Search',
                  hintText: 'Search by city name...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  String searchText = _searchController.text;
                  BlocProvider.of<WeatherBloc>(context)
                      .add(WeatherSearchCityEvent(searchText));
                  Navigator.pop(context);
                },
                child: const Text('Search'),
              ),
              const SizedBox(
                height: 10,
              ),
              // BlocBuilder<WeatherBloc, WeatherState>(
              //   builder: (context, state) {
              //     if (state is WeatherFetchSuccessfulState) {
              //       Weather weather = state.weather;
              //
              //       return Text('Weather: $weather');
              //     } else {
              //       return Text('No weather data available');
              //     }
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

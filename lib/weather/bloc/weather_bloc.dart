import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/utils/api_key.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<WeatherInitialFetchEvent>(weatherInitialFetchEvent);
  }

  FutureOr<void> weatherInitialFetchEvent(
      WeatherInitialFetchEvent event, Emitter<WeatherState> emit) async {
    var client = http.Client();
    try {
      var response = await client.get(Uri.parse(
          "http://api.weatherapi.com/v1/current.json?key=$API_KEY&q=London&aqi=no"));
      print("Called");
      print(response.body);
    } catch (e) {
      print(e.toString());
    }
  }
}

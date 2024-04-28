import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather.dart';
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
    Weather weather;
    try {
      Position position = await Geolocator.getCurrentPosition();
      var response = await client.get(Uri.parse(
          "http://api.weatherapi.com/v1/forecast.json?key=$API_KEY&q=${position.latitude},${position.longitude}&days=3&aqi=no&alerts=no"));

      weather = Weather.fromJson(json.decode(response.body));
      print("_-_-_-_-_-_-_-_-_-_-_-");
      print(response.body);
      print(weather);

      emit(WeatherFetchSuccessfulState(weather: weather));
    } catch (e) {
      print(e.toString());
    }
  }
}

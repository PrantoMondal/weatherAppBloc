part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {}

class WeatherInitialFetchEvent extends WeatherEvent {}

class WeatherSearchCityEvent extends WeatherEvent {
  final String city;

  WeatherSearchCityEvent(this.city);
}

class UnitChangeEvent extends WeatherEvent {}

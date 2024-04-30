part of 'weather_bloc.dart';

@immutable
abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

abstract class WeatherActionState extends WeatherState {}

class WeatherFetchSuccessfulState extends WeatherState {
  final Weather weather;

  WeatherFetchSuccessfulState({
    required this.weather,
  });
}

class WeatherSearchSuccessfulState extends WeatherState {
  final Weather weather;
  WeatherSearchSuccessfulState({
    required this.weather,
  });
}

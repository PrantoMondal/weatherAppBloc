part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {}

class WeatherInitialFetchEvent extends WeatherEvent {}

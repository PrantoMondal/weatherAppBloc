import 'package:bloc/bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/controller/weather_bloc/weather_bloc.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/utils/api_key.dart';

class MockClient extends Mock implements http.Client {}

class MockPosition extends Mock implements Position {}

void main() {
  group('WeatherBloc', () {
    test('should emit WeatherFetchSuccessfulState when API call succeeds',
        () async {
      // final mockPosition = MockPosition();
      //
      // when(mockPosition.latitude).thenReturn(12.345); // Mock latitude
      // when(mockPosition.longitude).thenReturn(-67.890); // Mock longitude
      // when(Geolocator.getCurrentPosition())
      //     .thenAnswer((_) async => mockPosition);

      when(mockClient.get(Uri.parse(
              "http://api.weatherapi.com/v1/forecast.json?key=$API_KEY&q=${12.345},${-67.890}&days=4&aqi=no&alerts=no")))
          .thenAnswer((_) async => http.Response('{"key": "value"}', 200));

      final weatherBloc = WeatherBloc();

      await weatherBloc.weatherInitialFetchEvent(
          WeatherInitialFetchEvent(), mockClient as Emitter<WeatherState>);

      expect(
        weatherBloc,
        emitsInOrder([
          WeatherFetchSuccessfulState(
              weather: Weather.fromJson({"key": "value"}))
        ]),
      );
    });
  });
}

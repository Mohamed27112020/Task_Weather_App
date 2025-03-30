import 'package:flutter_bloc/flutter_bloc.dart';

import '../Services/Weather_Service.dart';
import '../models/Weathermodel.dart';
import 'Weather_States.dart';

class WeatherCubit extends Cubit<WeatherStates> {
  WeatherCubit() : super(InitialWeather());
// ignore: non_constant_identifier_names
  String? Cityname;
  Weather weather = Weather();
  WeatherModel? weatherModel;

  void GetWeather({ String? cityname}) async {
    emit(LoadingWeather());
    try {
      weatherModel = await weather.getweather(cityname: Cityname!);
      emit(SuccessWeather());
    } on Exception catch (e) {
      print(e.toString());
      emit(ErrorWeather());
    }
  }
}

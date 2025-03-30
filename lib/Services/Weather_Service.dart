import 'dart:convert';
import 'package:http/http.dart'as http ;
import 'package:task_weather_app/models/Weathermodel.dart';


class Weather {

  Future<WeatherModel?> getweather ({required String cityname}) async{

    try {
      String baseurl ='http://api.weatherapi.com/v1';
      String apikey ='b14a3af330d64d5da82150800231007';

      Uri uri = Uri.parse('$baseurl/forecast.json?key=$apikey&q=$cityname&days=7');
       http.Response response =  await http.get(uri);
       Map<String , dynamic> JsonData = jsonDecode(response.body) ;
      // print(JsonData);
      WeatherModel weather = WeatherModel.fromJson(JsonData);
      return weather;
    } on Exception catch (e) {
     print(e.toString());
    }
    return null;
    //print(weather);
  }

}
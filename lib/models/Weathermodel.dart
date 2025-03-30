
import 'package:flutter/material.dart';

class WeatherModel{
   String? cityname;
   String? country;
   String? date;
   double? temp;
   double? maxtemp;
   double? mintemp;
   String? weatherstate;

  WeatherModel({ required this.cityname, required this.country,
    required this.date,required this.temp,required this.maxtemp,
    required this.mintemp,required this.weatherstate });


  WeatherModel.fromJson(dynamic JsonData){
    print(JsonData);
    cityname = JsonData['location']['name'];
    country = JsonData['location']['country'];
    date = JsonData['current']['last_updated'];
    temp = JsonData['forecast']['forecastday'][0]['day']['avgtemp_c'];
    maxtemp = JsonData['forecast']['forecastday'][0]['day']['maxtemp_c'];
    mintemp = JsonData['forecast']['forecastday'][0]['day']['mintemp_c'];
    weatherstate = JsonData['current']['condition']['text'];

  }

String getimage(){
    if(weatherstate == 'Clear' || weatherstate == 'Light Cloud '){
      return 'assets/images/clear.png';
    }else if (weatherstate == 'Sleet'||weatherstate =='Snow'||weatherstate =='Hail'){
      return 'assets/images/snow.png';
    }else if(weatherstate == 'Heavy Cloud'){
      return 'assets/images/cloudy.png';
    }else if(weatherstate=='Light Rain'||weatherstate=='Heavy Rain' || weatherstate =='Showers'){
      return 'assets/images/rainy.png';
    }else if (weatherstate == 'Thunderstorm'){
      return 'assets/images/thunderstorm.png';
    }else{
      return 'assets/images/clear.png';
    }
}

   MaterialColor getColorTheme(){
     if(weatherstate == 'Clear' || weatherstate == 'Light Cloud '){
       return Colors.orange;
     }else if (weatherstate == 'Sleet'||weatherstate =='Snow'||weatherstate =='Hail'){
       return Colors.cyan;
     }else if(weatherstate == 'Heavy Cloud'){
       return Colors.red;
     }else if(weatherstate=='Light Rain'||weatherstate=='Heavy Rain' || weatherstate =='Showers'){
       return Colors.green;
     }else if (weatherstate == 'Thunderstorm'){
       return Colors.blue;
     }else{
       return Colors.yellow;
     }
   }


}

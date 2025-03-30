import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_weather_app/Cubit/Weather_cubit.dart';

class searchppage extends StatelessWidget {
  searchppage({Key? key}) : super(key: key);
  //  TextEditingController cityname = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Search a City ")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            onChanged: (data) {
              BlocProvider.of<WeatherCubit>(context).Cityname = data;
            },
            onSubmitted: (data) {
              BlocProvider.of<WeatherCubit>(context).Cityname = data;

              BlocProvider.of<WeatherCubit>(context).GetWeather();
              Navigator.pop(context);
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                vertical: 32,
                horizontal: 24,
              ),
              label: Text("search"),
              suffixIcon: IconButton(
                onPressed: () {
                  BlocProvider.of<WeatherCubit>(context).GetWeather(
                    cityname: BlocProvider.of<WeatherCubit>(context).Cityname!,
                  );
                  Navigator.pop(context);
                },
                icon: Icon(Icons.search),
              ),
              border: OutlineInputBorder(),
              hintText: 'Enter a City',
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_weather_app/Component/Custombutton.dart';
import 'package:task_weather_app/Cubit/Weather_States.dart';
import 'package:task_weather_app/Cubit/Weather_cubit.dart';
import 'package:task_weather_app/models/Weathermodel.dart';
import 'package:task_weather_app/pages/Login_Screen.dart';
import 'package:task_weather_app/pages/search_page.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  WeatherModel? weatherModel;
  @override
  Widget build(BuildContext context) {
    weatherModel = BlocProvider.of<WeatherCubit>(context).weatherModel;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Login_Page();
                  },
                ),
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
        title: const Text('Weather App'),
      ),
      body: BlocBuilder<WeatherCubit, WeatherStates>(
        builder: (context, state) {
          if (state is InitialWeather) {
            return const InitialFun();
          } else if (state is LoadingWeather) {
            return const LoadingFun();
          } else if (state is SuccessWeather) {
            return SuccessFun();
          } else {
            return Center(child: Text('Something went Wrong !'));
          }
        },
      ),
    );
  }
}

class SuccessFun extends StatelessWidget {
  SuccessFun({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(BlocProvider.of<WeatherCubit>(context).Cityname);
    print(BlocProvider.of<WeatherCubit>(context).weatherModel!.temp);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            BlocProvider.of<WeatherCubit>(
              context,
            ).weatherModel!.getColorTheme(),
            BlocProvider.of<WeatherCubit>(
              context,
            ).weatherModel!.getColorTheme()[300]!,
            BlocProvider.of<WeatherCubit>(
              context,
            ).weatherModel!.getColorTheme()[100]!,
          ],
        ),
      ),
      // color: Colors.orange,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(flex: 3),
          Text(
            '${BlocProvider.of<WeatherCubit>(context).weatherModel!.cityname}',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          Text(
            '${BlocProvider.of<WeatherCubit>(context).weatherModel!.country}',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            'updated : ${BlocProvider.of<WeatherCubit>(context).weatherModel!.date}',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.normal),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                BlocProvider.of<WeatherCubit>(context).weatherModel!.getimage(),
              ),
              Text(
                '${BlocProvider.of<WeatherCubit>(context).weatherModel!.temp}',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              Column(
                children: [
                  Text(
                    'maxTemp : ${BlocProvider.of<WeatherCubit>(context).weatherModel!.maxtemp} ',
                  ),
                  Text(
                    'minTemp : ${BlocProvider.of<WeatherCubit>(context).weatherModel!.mintemp}',
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          Text(
            '${BlocProvider.of<WeatherCubit>(context).weatherModel!.weatherstate}',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const Spacer(flex: 5),
          custombutton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return searchppage();
                  },
                ),
              );
            },
            namebutton: "Another Search",
          ),
        ],
      ),
    );
  }
}

class LoadingFun extends StatelessWidget {
  const LoadingFun({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}

class InitialFun extends StatelessWidget {
  const InitialFun({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('there is no weather 😔 start', style: TextStyle(fontSize: 24)),
          Text('searching now 🔍', style: TextStyle(fontSize: 24)),
          SizedBox(height: 40),
          custombutton(
            namebutton: "Search Now",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return searchppage();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

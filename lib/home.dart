import 'package:banha3_api/model/quotes_response.dart';
import 'package:banha3_api/network/api_service.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> cities = ['London', 'Paris', 'New York'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<WeatherResponse>(
          future: ApiService.api.fetchWeatherData(cities),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<CityWeather> citiesWeather = snapshot.data!.citiesWeather;
              return ListView.builder(
                itemCount: citiesWeather.length,
                itemBuilder: (context, index) => ListTile(
                  leading: Image.network(
                    'https://openweathermap.org/img/wn/${citiesWeather[index].icon}@2x.png',
                    width: 50,
                    height: 50,
                  ),
                  title: Text(citiesWeather[index].cityName),
                  subtitle: Text(citiesWeather[index].description),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  snapshot.error.toString(),
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

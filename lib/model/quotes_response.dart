class WeatherResponse {
  List<CityWeather> citiesWeather = [];
  WeatherResponse(this.citiesWeather);

  WeatherResponse.fromJson(Map<String, dynamic> json) {
    citiesWeather.add(CityWeather.fromJson(json));
  }
}

class CityWeather {
  String cityName;
  String description;
  String icon;

  CityWeather(this.cityName, this.description, this.icon);

  factory CityWeather.fromJson(Map<String, dynamic> json) {
    return CityWeather(
      json['name'],
      json['weather'][0]['description'],
      json['weather'][0]['icon'],
    );
  }
}

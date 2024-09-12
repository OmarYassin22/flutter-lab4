import 'dart:convert';
import 'dart:io';
import 'package:banha3_api/model/quotes_response.dart';
import 'package:banha3_api/network/api_exception.dart';
import 'package:banha3_api/network/constants.dart';
import 'package:http/http.dart' as http;

class ApiService {
  ApiService._();
  static final ApiService api = ApiService._();

  Future<WeatherResponse> fetchWeatherData(List<String> cities) async {
    List<CityWeather> citiesWeather = [];
    for (String city in cities) {
      Uri url = Uri.parse('$baseUrl/weather?q=$city&appid=$apiKey');
      try {
        http.Response response = await http.get(url);
        var jsonData = json.decode(response.body);
        if (response.statusCode == 200) {
          citiesWeather.add(CityWeather.fromJson(jsonData));
        } else {
          throw ApiException.fromJson(jsonData);
        }
      } on HttpException catch (e) {
        throw ApiException(0, e.message);
      }
    }
    return WeatherResponse(citiesWeather);
  }
}

import 'dart:convert';

import 'package:flutter_flicker_test/models/sys_model.dart';
import 'package:flutter_flicker_test/models/wind_model.dart';

import 'main_temp_model.dart';

WeatherDataModel getWeatherDataModelFromJson(String str) =>
    WeatherDataModel.fromJson(json.decode(str));

class WeatherDataModel {
  dynamic coord;
  dynamic weather;
  MainTemp? main;
  Wind? wind;
  SysModel? sys;
  dynamic clouds;
  String? name;
  WeatherDataModel(
      {this.coord,
      this.weather,
      this.main,
      this.wind,
      this.sys,
      this.clouds,
      this.name});

  factory WeatherDataModel.fromJson(Map<String, dynamic> data) {
    return WeatherDataModel(
        coord: data["coord"],
        weather: data["weather"],
        main: data["main"] != null ? MainTemp.fromJson(data["main"]) : null,
        wind: Wind.fromJson(data["wind"]),
        sys: SysModel.fromJson(data["sys"]),
        clouds: data["title"],
        name: data["name"]);
  }
}

var temps = {
  "temp": 284.24,
  "feels_like": 283.78,
  "temp_min": 283.07,
  "temp_max": 285.21,
  "pressure": 1022,
  "humidity": 91
};

class MainTemp {
  double? temp;
  double? feelsLike;
  double? tempMin;
  double? tempMax;
  int? pressure;
  int? humidity;
  MainTemp({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
  });
  factory MainTemp.fromJson(Map<String, dynamic> data) {
    return MainTemp(
        temp: data["temp"],
        feelsLike: data["feels_like"],
        tempMin: data["temp_min"],
        tempMax: data["temp_max"],
        pressure: data["pressure"],
        humidity: data["humidity"]);
  }
}

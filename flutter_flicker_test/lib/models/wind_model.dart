class Wind {
  double? speed;
  int? deg;
  Wind({
    this.speed,
    this.deg,
  });
  factory Wind.fromJson(Map<String, dynamic> data) {
    return Wind(speed: data["speed"], deg: data["deg"]);
  }
}

class SysModel {
  int? type;
  int? id;
  String? country;
  int? sunrise;
  int? sunset;
  SysModel({
    this.type,
    this.id,
    this.country,
    this.sunrise,
    this.sunset,
  });
  factory SysModel.fromJson(Map<String, dynamic> data) {
    return SysModel(
      type: data["type"],
      id: data["id"],
      country: data["country"],
      sunrise: data["sunrise"],
      sunset: data["sunset"],
    );
  }
}

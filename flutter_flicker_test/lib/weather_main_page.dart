import 'package:flutter/material.dart';
import 'package:flutter_flicker_test/models/weather_model.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:sizer/sizer.dart';

class WeatherMainPage extends StatefulWidget {
  const WeatherMainPage({Key? key}) : super(key: key);

  @override
  _WeatherMainPageState createState() => _WeatherMainPageState();
}

class _WeatherMainPageState extends State<WeatherMainPage> {
  WeatherDataModel? whetherData;
  Future<void> getWeatherData({double? log, double? lat}) async {
    print("$log $lat");
    Uri uri = Uri.parse(
        "http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lat&appid=5ed9bcac96a3469cdf751f9fff579bd4");
    var res = await http.get(uri);
    WeatherDataModel data = getWeatherDataModelFromJson(res.body);
    whetherData = data;
    setState(() {});
    print(res.body);
  }

  Future<void> getLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    await getWeatherData(
        lat: _locationData.latitude, log: _locationData.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        // floatingActionButton: Center(
        //   child: Row(
        //     children: [
        //       MText("Fetch Location and Weather"),
        //       FloatingActionButton(

        //       ),
        //     ],
        //   ),
        // ),
        body: Container(
          height: 50.0.h,
          padding: EdgeInsets.symmetric(vertical: 2.0.h, horizontal: 5.0.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MaterialButton(
                color: Colors.blue,
                child: Row(
                  children: [
                    Icon(Icons.ac_unit),
                    MText("Fetch Location and Weather"),
                  ],
                ),
                onPressed: () async {
                  // await getWeatherData();
                  getLocation();
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MText(
                      "Location : ${whetherData?.name ?? ""} ${whetherData?.sys?.country ?? ""}"),
                  MText("${whetherData?.weather[0]["description"] ?? ""}")
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MText("Longitude : ${whetherData?.coord["lon"] ?? ""}"),
                  MText("Latitude : ${whetherData?.coord["lat"] ?? ""}"),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MText(
                    "Temperature",
                    fontSize: 15.0.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  MText(
                    "Temp : ${whetherData?.main?.temp ?? ""}\u00B0",
                  ),
                  MText(
                    "Min Temp : ${whetherData?.main?.tempMin ?? ""}\u00B0",
                  ),
                  MText(
                    "Min Temp : ${whetherData?.main?.tempMax ?? ""}\u00B0",
                  ),
                  MText(
                    "Humidity : ${whetherData?.main?.humidity ?? ""}",
                  ),
                  MText(
                    "Pressure : ${whetherData?.main?.pressure ?? ""}",
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MText(
                    "Wind :",
                    fontSize: 15.0.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  MText(
                    "Speed : ${whetherData?.wind?.speed ?? ""}",
                  ),
                  MText(
                    "Deg : ${whetherData?.wind?.deg ?? ""}",
                  ),
                ],
              ),
              Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MText(
                    "Forecast :",
                    fontSize: 15.0.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  MText("${whetherData?.weather[0]["main"] ?? ""}"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MText extends StatelessWidget {
  final double? fontSize;
  final FontWeight? fontWeight;
  final String text;
  const MText(this.text, {Key? key, this.fontSize, this.fontWeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: fontSize ?? 14.0.sp,
          fontWeight: fontWeight ?? FontWeight.normal),
    );
  }
}

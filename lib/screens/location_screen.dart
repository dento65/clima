import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'dart:developer';
import 'city_screen.dart';
import 'package:clima/services/networking.dart';

class LocationScreen extends StatefulWidget {
  final locationWeather;
  LocationScreen({Key key, this.locationWeather}) : super(key: key);




  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int temperature;
  String weatherIcon;
  String cityName;
  String weatherMessage;

  @override
  void initState() {


    updateUI(super.widget.locationWeather);
    print(super.widget.locationWeather);
    super.initState();
  }

  void updateUI(dynamic weatherData) {
    temperature = 0;
    weatherIcon = 'Error 1';
    weatherMessage = 'Unable to get weather data';
    cityName = '';
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        weatherMessage = 'Unable to get weather data';
        cityName = '';
        return;
      }
      double temp = weatherData['current']['temp_c'];
      temperature = temp.toInt();
      weatherIcon = weather.getWeatherIcon(weatherData['current']['condition']['code']);
      weatherMessage = weather.getMessage(temperature);
      cityName = weatherData['location']['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {

                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var typedName = await Navigator.push( // this here has 2 func
                        //1. to take us to the next route
                        //2. when we pop in the other route the argument that we pass there is stored
                        // this var
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );
                      NetworkHelper networkHelper = NetworkHelper(
                          'https://api.weatherapi.com/v1/current.json?key=%2001b3052b0f4b4b4a95591526210909&q=$typedName');
                      var EaruM = await networkHelper.getData();
                      updateUI(EaruM);

                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$weatherMessage in $cityName',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
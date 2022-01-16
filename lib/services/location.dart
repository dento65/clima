import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Location {
  double latitude, longitude;



  Future<void> getLocation() async //here we use async function because we want time
  //we are using future because func if it returns something will return it in future not immediately
  // and this also applies for type void
  //consuming tasks to happen in background instead of foreground resulting in freezing of app
  {
    try {
      Position position = await Geolocator.getCurrentPosition( // Postition is data type fom package geolocator
          desiredAccuracy: LocationAccuracy.low);
      latitude = position.latitude;
      longitude = position.longitude;
      // await is used because it takes time to get location and prevents app from freezing
    } catch (exception) {
      print(exception);
    }
  }
}

//var is a dynamic data type it can be used to store any data

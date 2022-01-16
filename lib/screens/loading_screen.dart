import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// the more high the accuracy level of the location the more battery is
//consumed so use high accuracy only when needed
// class LoadingScreen extends StatefulWidget {
//   @override
//   _LoadingScreenState createState() => _LoadingScreenState();
// }
//
// class _LoadingScreenState extends State<LoadingScreen> {
//
//   void getLocation () async //here we use async function because we want time
//   //consuming tasks to happen in background instead of foreground resulting in freezing of app
//   {
//     Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
//     // await is used because it takes time to get location and prevents app from freezing
//     print(position);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: RaisedButton(
//           onPressed: () {
//             //Get the current location
//             getLocation();
//           },
//           child: Text('Get Location'),
//         ),
//       ),
//     );
//   }
// }
// //by default things happen synchronously on after the other next thing doesnt happen until
//previous gets completed
// but when we use
// async it means not effecting other things even when it takes a lot of time
//the rest of the things happen until async func gets completed


// Asynchronous operations let your program complete work while waiting
// for another operation to finish. Here are some common asynchronous operations:
//
// Fetching data over a network.
// Writing to a database.
// Reading data from a file.
// To perform asynchronous operations in Dart, you can use the Future class and the async and await keywords.

// we want the location to be accesed when the screen loads as it is a weather app
// so we cannot put a button instead location should be there when the state
// widget is made/build for that we have to know 3 IMP prop of stateful/less widgets/ LIFECYCLE Methods:
// 1. initState (function) is called when object is inserted into the tree OR
// simply when we create stateful widget
// 2. build (most frequently used) every time widgets in the stateful widget are made
// or when the build is complete. It is even called when sate is modified (i.e by setState)
// 3. deactivate when the statedul widget is destroyed
//
//
// class LoadingScreen extends StatefulWidget {
//   @override
//   _LoadingScreenState createState() => _LoadingScreenState();
// }
//
// class _LoadingScreenState extends State<LoadingScreen> {
//
//   void initState(){
//     getLocation();
//   }
//
//   void getLocation () async //here we use async function because we want time
//   //consuming tasks to happen in background instead of foreground resulting in freezing of app
//       {
//     Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
//     // await is used because it takes time to get location and prevents app from freezing
//     print(position);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//     );
//   }
// }
//EXCEPTIONS IN DART(throw and catch):
// WHY DO we need them?
// what will happen if something goes wrong even when there are no compilation errors
// like here it can be like user doent allow location access or maybe we fail to get
// the location maybe the connection is weak.
// TRY AND CATCH
// in that we try something if it works good if not we catch the exception/error automatically thrown
// and do something else
//   i.e
//   main() {
//     try {
//       test_age(-2);
//     }
//     catch(e) { // catch(exception)
//       print('Age cannot be negative'); // print(e) tells to print the erroe/exception
//     }
//   }
// void test_age(int age) {
//   if(age<0) {
//     throw new FormatException();
//   }
// }
// Null-aware operators(??) in dart allow you to make
// computations based on whether or not a value is null. It’s shorthand for longer expressions
// (if this is not null)?? (defalut (if previous exp is not null))
//
//
// THROW:
//     to catch an exception we first have to throw and exception is some cases(like :
// when error occurs in geo locator inside the code it is written when and how to throw
// // an exception so we dont need to write throw there manually )
// class LoadingScreen extends StatefulWidget {
//   @override
//   _LoadingScreenState createState() => _LoadingScreenState();
// }
//
// class _LoadingScreenState extends State<LoadingScreen> {
//   Location location = Location();
//    void getLocation() async
//   {
//
//     await location.getLocation();
//     print(location.latitude);
//     print(location.longitude);
//   }
//   void getData() async
//   {
//     var url = Uri.parse('https://api.weatherapi.com/v1/current.json?key=%2001b3052b0f4b4b4a95591526210909&q=$location.latitude,location.longitude');
//     http.Response response = await http.get(url);
//     //in header import 'package:http/http.dart' as http; so before each func of http package
//     // we have to use http. so we know get method comes from http package
//     if(response.statusCode==200)
//     print(response.body);
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//      getData();
//     return Scaffold(
//
//     );
//   }
// }

// we add http package to make request to any server
//we use Response data type to store the data/response from the get method (server finally)
// the response is big has various properties the part that we are interested in
// is the body of the response or may we can check status code of response
//HTTP status codes are generated by a web server every time a file is requested. It's just
// that you rarely see them. The codes enable us to identify any issues and pinpoint that issue if a
// webpage or other resources, like image files or scripts that fail to properly load.
// 1** : Hold On.
// 2** : It's All Good.
// 3** : Go Somewhere Else.
// 4** : You F'd Up.
// 5** : I F'd Up.


//there is one important thing that when we use the method/objects of a
// plugin sometime we get confused wether i created the func/widget/objects
// is it default or is it from the package to solve this after each
// package we us( as name) now every  object/method  will
//be use as name.func_name


class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Location location = Location(); // loctaion object from Location.dart file
  void initState() { // this function runs as soon as state widget is created
    super.initState();
    getLocationData();
  }
  void getLocationData() async  // async func also await is used
      {
    await location
        .getLocation(); // await is used as method getLocation takes time

    //in header import 'package:http/http.dart' as http; so before each func of http package
    // we have to use http. so we know get method comes from http package
    NetworkHelper networkHelper = NetworkHelper(
        'https://api.weatherapi.com/v1/current.json?key=%2001b3052b0f4b4b4a95591526210909&q=$location.latitude,$location.longitude');
    // networkhelper is object from networking.dart
    try {
      var weatherData = await networkHelper
          .getData(); // this method of class Networkhelper returns inline data (not JSON)

      var route = new MaterialPageRoute(
        builder: (BuildContext context) =>
        new LocationScreen(locationWeather: weatherData),
      );
      Navigator.of(context).push(route);
    }
    catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(    //content to be displayed before changing route (moving to other page)
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),

    );
  }
}
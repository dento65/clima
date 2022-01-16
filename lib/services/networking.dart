


import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  final String url;
  NetworkHelper(this.url);


  Future getData() async {   //we are using future because func if it returns something will return it in future not immediately
    http.Response response = await http.get(Uri.parse(url)); // http. is used
    // because in import to  not get confused  in default and package widgets ever before used any object
    //from http package use http.name

    if (response.statusCode == 200) {  // 200 status code => everything is all right
      String data = response.body;

      return jsonDecode(data);     // here it decodes the the JSON data serialises it inline(dart format) form import 'dart:convert'
    } else {
      print(response.statusCode);   // prints the error code
    }
  }
}
// API Stands for "Application Programming Interface." An API is a set of commands,
// functions, protocols, and objects that programmers can use to
// create software or interact with an external system
// servers generally give us data in xml or JSON format
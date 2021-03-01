import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  getLocation() async{
    try{
      Position position = await Geolocator.
      getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      print(position);
    }catch(e){
      print('exeption');
    }
  }

  fetchData() async{
    Response response = await get('https://samples.openweathermap.org/data/2.5/weather?q=London&appid=b1b15e88fa797225412429c1c50c122a1');
    print(response.body);
    if(response.statusCode == 200){
      String json = response.body;
      var myJson = jsonDecode(json)['weather'][0]['description'];
      print(myJson);
    }
  }

  @override
  void initState() {
    getLocation();
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: null,
          child: Text('get my location',
          style: TextStyle(
            color: Colors.white
          ),
          ),
          color: Colors.blue,
        ),
      ),
    );
  }
}


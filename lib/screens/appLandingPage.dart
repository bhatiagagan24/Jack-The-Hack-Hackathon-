// login screen

// ignore_for_file: file_names

// import 'dart:ffi';

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'package:smart_journey_experience/screens/app_deals.dart';
import 'package:smart_journey_experience/screens/app_help.dart';
import 'package:smart_journey_experience/screens/app_about_us.dart';

import 'app_Login.dart';

class HomeScreenPhotos {
  var photo_name;
  var id;
  HomeScreenPhotos({this.photo_name, this.id});
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  List AirportList = [];

  var temp_variable = 0;

  Future<List<HomeScreenPhotos>> getImageUri() async {
    List<HomeScreenPhotos> name_list = [];
    var new_name_list = [];
    print('inside future function');
    final url = Uri.parse('http://192.168.1.10:5000/urlfetch/getlinks');
    http.Response response = await http.get(url);
    print(response.body);
    var respdata = json.decode(response.body);
    print(respdata);

    for (var i = 0; i < respdata.length; i++) {
      print("inside for loop");
      print(respdata[i]['imageName']);
      print(respdata[i]);
      HomeScreenPhotos temp1 =
          new HomeScreenPhotos(photo_name: respdata[i]['imageName'], id: i);
      name_list.add(temp1);
      new_name_list.add(respdata[i]['imageName']);
    }

    print("named list -> ");
    print(name_list[0]);
    return name_list;
  }

  @override
  void initState() {
    // super.initState();
    getAirportData();
    // getData("");
  }

  Future<void> getAirportData() async {
    var temp_AirportList = [];
    // print("Inside get airport data");
    // log("Inside get airport data");
    final uri_for_airport_list =
        Uri.parse('http://192.168.1.10:5000/airports/get');
    http.Response resp = await http.get(uri_for_airport_list);
    var respdata = json.decode(resp.body);
    // print("Data fetched by getAirportData() -> ");
    // print(respdata);
    // temp_AirportList.add('All');
    for (var i = 0; i < respdata.length; i++) {
      temp_AirportList.add(respdata[i][1]);
    }
    // print("Temp airport list :- ");
    // print(temp_AirportList);
    setState(() {
      AirportList = temp_AirportList;
    });
    // print("AirportList now: -");
    // print(AirportList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.all(20)),
          Center(
              child: Image.asset(
            "assets/home_page.png",
            height: 300,
            width: 300,
          )),
          Padding(padding: EdgeInsets.all(5)),
          Center(
              child: Text(
            "Digitizing your Airport Experience.",
            style: TextStyle(fontSize: 20),
          )),
          SizedBox(
            height: 10,
          ),
          Center(child: SignIn(AirportList: this.AirportList)),
          // Padding(padding: EdgeInsets.all(10)),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton.icon(
                  // onPressed: () {},
                  onPressed: () {
                    getAirportData();
                    print("this is the temp var ${temp_variable}");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Deals(
                                AirportList: this.AirportList,
                              )),
                    );
                  },
                  icon: Icon(Icons.shopping_bag_outlined),
                  label: Text('Shopping and Dining Deals')),
            ],
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ButtonBar(
                children: <Widget>[
                  TextButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AboutUS()),
                        );
                      },
                      icon: Icon(Icons.group),
                      label: Text('About Us')),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Help()),
                      );
                    },
                    icon: Icon(Icons.help),
                    label: Text('Help'),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

// this model sheet pops up when Google sign-in button pressed


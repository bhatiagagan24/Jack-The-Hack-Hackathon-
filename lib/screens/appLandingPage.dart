// login screen

// ignore_for_file: file_names

// import 'dart:ffi';

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'package:smart_journey_experience/screens/app_deals.dart';
import 'package:smart_journey_experience/screens/app_deals_food.dart';

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
    var screen_width = MediaQuery.of(context).size.width;
    return ListView(
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        // scrollDirection: Axis.vertical,
        // child:
        Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // ignore: avoid_unnecessary_containers

            ButtonBar(
              alignment: MainAxisAlignment.center,
              // layoutBehavior: ,
              children: <Widget>[
                Container(
                  width: screen_width,
                  child: ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: 200,
                            child: Center(
                              child: Text('This is the Modal Sheet'),
                            ),
                          );
                        },
                      );
                    },
                    child: Text('Google Sign-in'),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.lightGreen.shade300),
                  ),
                ),
              ],
            ),
            // ),
          ],
        ),
        ButtonBar(
          alignment: MainAxisAlignment.spaceAround,
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
                label: Text('Shopping Deals')),
            TextButton.icon(
              onPressed: () {
                getAirportData();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DealsFood(
                            AirportList: this.AirportList,
                          )),
                );
              },
              icon: Icon(Icons.food_bank_outlined),
              label: Text('Dining Deals'),
            ),
          ],
        ),
        FutureBuilder(
          future: getImageUri(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData != true) {
              // log(snapshot);
              log("data was not there in the snapshot");
              return Container(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data.length,
                itemBuilder: (ctx, index) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // Text(snapshot.data[index].photo_name),
                    Container(
                      height: 200,
                      width: screen_width,
                      child: Card(
                        child: Image.network(
                          "http://192.168.1.10:5000/static/media/" +
                              snapshot.data[index].photo_name,
                          fit: BoxFit.fill,
                          width: screen_width,
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
          },
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              ButtonBar(
                alignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ButtonBar(
                    children: <Widget>[
                      TextButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.group),
                          label: Text('About Us')),
                      TextButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.help),
                        label: Text('Help'),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}

// this model sheet pops up when Google sign-in button pressed


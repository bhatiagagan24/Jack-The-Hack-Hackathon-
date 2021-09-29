// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CardsPastTrips extends StatefulWidget {
  var user_name;
  var user_email;
  CardsPastTrips({
    Key? key,
    @required this.user_email,
    @required this.user_name,
  }) : super(key: key);

  @override
  State<CardsPastTrips> createState() => _CardsPastTripsState();
}

class _CardsPastTripsState extends State<CardsPastTrips> {
  @override
  Future<List> fetchPast_Trips() async {
    var urlString = 'http://192.168.1.10:5000/user/info/fetch?';
    var queryParam = {"username": widget.user_name, "email": widget.user_email};
    var queryString = Uri(queryParameters: queryParam).query;
    var url = Uri.parse(urlString + queryString);
    http.Response resp = await http.get(url);
    print(resp.body);
    var respdata = json.decode(resp.body);
    var travel_list = [];
    for (var i = 0; i < respdata.length; i++) {
      print('inside for loop');
      var temp_list = [];
      temp_list.add(respdata[i]["flightcode"]);
      print("flightcode -> ");
      print(respdata[i]["flightcode"]);
      temp_list.add(respdata[i]["timeuploaded"]);
      travel_list.add(temp_list);
      print("temp_list now ---> ${temp_list}");
    }
    log("travel list --->  ${travel_list}");
    return travel_list;
  }

  @override
  Widget build(BuildContext context) {
    var screen_width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text('My Past Trips'),
      ),
      body: new FutureBuilder(
          future: fetchPast_Trips(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData != true) {
              return CircularProgressIndicator();
            } else {
              return ListView.builder(
                // shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) => Row(children: <Widget>[
                  // Text('Information here'),
                  // ElevatedButton(
                  //     onPressed: () {
                  //       print(snapshot.data[index]);
                  //     },
                  // child: Text('Check Content')),
                  // Text(snapshot.data[index][0]),
                  Container(
                    height: 100,
                    width: screen_width,
                    child: Card(
                      color: Colors.black12,
                      child: Center(
                        child: Text(
                          snapshot.data[index][0],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.blue.shade100,
                          ),
                        ),
                      ),
                    ),
                  )
                ]),
              );
            }
          }),
      // ],
    );
    // )
  }
}

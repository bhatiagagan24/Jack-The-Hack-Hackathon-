import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';

class HelpSignedIn extends StatelessWidget {
  var username, email, airport;
  HelpSignedIn(
      {Key? key,
      required this.username,
      required this.email,
      required this.airport})
      : super(key: key);
  String airport_email = "", airport_number = "";
  Future<void> get_help_data() async {
    Map<String, String> queryParams = {
      "airportname": "$airport",
    };
    String queryString = Uri(queryParameters: queryParams).query;
    var requesturl = 'http://192.168.1.10:5000/food/fetch?' + queryString;
    var uri = Uri.parse(requesturl);
    Response response = await get(uri);
    List help = (jsonDecode(response.body) as List<dynamic>).cast<String>();
    airport_email = help[1];
    airport_number = help[0];
  }

  @override
  void initState() {
    get_help_data();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Help",
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: Colors.deepPurple.shade200,
          centerTitle: true,
        ),
        backgroundColor: Colors.lightGreen,
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Center(
                // child: Text(
                //   "Help",
                //   style: TextStyle(
                //       fontSize: 40,
                //       fontWeight: FontWeight.bold,
                //       color: Colors.blue),
                // ),
                ),
            Padding(padding: EdgeInsets.all(40)),
            Container(
              width: 450,
              height: 450,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 5,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 40),
                    FaIcon(FontAwesomeIcons.question,
                        size: 50.0, color: Colors.red),
                    SizedBox(height: 40),
                    Center(
                        child: Text(
                      "You can contact from details given below:",
                      style: TextStyle(fontSize: 20),
                    )),
                    Padding(padding: EdgeInsets.all(15)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          airport_number,
                          style: TextStyle(fontSize: 20),
                        ),
                        FaIcon(FontAwesomeIcons.phone, color: Colors.red)
                      ],
                    ),
                    Padding(padding: EdgeInsets.all(10)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          airport_email,
                          style: TextStyle(fontSize: 20),
                        ),
                        FaIcon(FontAwesomeIcons.envelope, color: Colors.red)
                      ],
                    ),
                  ],
                ),
                margin: EdgeInsets.all(10.0),
              ),
            )
          ],
        ));
  }
}

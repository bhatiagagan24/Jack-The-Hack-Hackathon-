import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';

class Assistance extends StatefulWidget {
  String user_name;
  String user_email;
  String airport;
  Assistance(
      {Key? key,
      required this.user_name,
      required this.user_email,
      required this.airport})
      : super(key: key);

  @override
  _AssistanceState createState() => _AssistanceState();
}

class _AssistanceState extends State<Assistance> {
  String res = "";
  Future<void> sendRequest(String service) async {
    Map<String, String> queryParams = {
      "airportname": "${widget.airport}",
      "email": "${widget.user_email}",
      "username": "${widget.user_name}",
      "service": "$service"
    };
    String queryString = Uri(queryParameters: queryParams).query;
    var requesturl =
        'http://192.168.1.10:5000/assistance/request?' + queryString;
    var uri = Uri.parse(requesturl);
    Response response = await get(uri);
    res = response.body;
    var respdata = json.decode(res);
    print("Respdata --- > ${respdata}");
    print(respdata.runtimeType);
    setState(() {
      res = respdata;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[200],
        title: Text("Assistance"),
        centerTitle: true,
      ),
      body: GridView.count(crossAxisCount: 2, children: <Widget>[
        GestureDetector(
          onTap: () {
            sendRequest("WheelChair");
            if (res == "1") {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Request Sent")));
            } else if (res == "-1") {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Try Again")));
            }
          },
          child: Container(
              height: 200,
              child: Card(
                margin: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  children: [
                    Padding(padding: EdgeInsets.all(20)),
                    FaIcon(
                      FontAwesomeIcons.wheelchair,
                      color: Colors.purple[200],
                    ),
                    Padding(padding: EdgeInsets.all(20)),
                    Text("WheelChair")
                  ],
                ),
              )),
        ),
        GestureDetector(
          onTap: () {
            sendRequest("First Aid");
            if (res == "1") {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Request Sent")));
            } else {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Try Again")));
            }
          },
          child: Container(
              height: 200,
              child: Card(
                margin: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  children: [
                    Padding(padding: EdgeInsets.all(20)),
                    FaIcon(
                      FontAwesomeIcons.medkit,
                      color: Colors.purple[200],
                    ),
                    Padding(padding: EdgeInsets.all(20)),
                    Text("First Aid")
                  ],
                ),
              )),
        ),
      ]),
    );
  }
}

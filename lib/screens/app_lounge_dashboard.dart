import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:smart_journey_experience/screens/app_food_load.dart';

class LoungeDashboard extends StatelessWidget {
  String user_name, user_email;
  String name;
  String res = "";
  LoungeDashboard(
      {Key? key,
      required this.user_name,
      required this.user_email,
      required this.name})
      : super(key: key);
  List food_list = [];
  Future<void> get_food_data(var loungename) async {
    Map<String, String> queryParams = {
      "loungename": "$loungename",
      // "email": "$user_email"
    };
    String queryString = Uri(queryParameters: queryParams).query;
    var requesturl = 'http://192.168.1.10:5000/food/fetch?' + queryString;
    var uri = Uri.parse(requesturl);
    Response response = await get(uri);
    food_list = (jsonDecode(response.body) as List<dynamic>).cast<String>();
    print(food_list);
  }

  Future<void> check_eligibility() async {
    Map<String, String> queryParams = {
      // "loungename": "$loungename",
      "email": "${user_email}",
      "username": "${user_name}",
    };
    String queryString = Uri(queryParameters: queryParams).query;
    var requesturl = 'http://192.168.1.10:5000/food/fetch?' + queryString;
    var uri = Uri.parse(requesturl);
    Response response = await get(uri);
    res = response.body;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xff7c94b6),
            image: new DecorationImage(
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.2), BlendMode.dstATop),
              image: new NetworkImage(
                "https://images.unsplash.com/photo-1504150558240-0b4fd8946624?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=764&q=80",
              ),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
              backgroundColor: Colors.black,
              centerTitle: true,
              title: Text(
                "Lounges",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow[400]),
              )),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(padding: EdgeInsets.all(10)),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "${name}",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow.shade400),
                ),
              ),
              Padding(padding: EdgeInsets.all(10)),
              Expanded(
                  child: GridView.count(
                crossAxisCount: 2,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      check_eligibility();
                      if (res == "1") {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("You are eligible")));
                      } else if (res == "-1") {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("You are not eligible")));
                      }
                    },
                    child: Container(
                      //Container to resize the
                      padding: EdgeInsets.all(20),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.yellow.shade400)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.checkCircle,
                              size: 40,
                              color: Colors.yellow.shade400,
                            ),
                            Center(
                                child: Text("Eligibility Check",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black))),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      get_food_data(this.name);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FoodLoad(
                                    food_item: this.food_list,
                                    // food_item: ["Rajma", "Chole"],
                                  )));
                    },
                    child: Container(
                      //Container to resize the
                      padding: EdgeInsets.all(20),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.yellow.shade400)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.utensils,
                              size: 40,
                              color: Colors.yellow.shade400,
                            ),
                            Center(
                                child: Text("Food on Menu",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black))),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )),
            ],
          ),
        ),
      ],
    );
  }
}

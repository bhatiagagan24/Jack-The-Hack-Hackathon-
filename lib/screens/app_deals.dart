import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Deals extends StatefulWidget {
  var AirportList;
  Deals({Key? key, @required this.AirportList}) : super(key: key);

  @override
  _DealsState createState() => _DealsState();
}

class _DealsState extends State<Deals> {
  List AirportList = [];
  // String? dropdownValue = 'All';
  @override
  void initState() {
    super.initState();
    print("AirportList value: - ");
    print(widget.AirportList);
    AirportList = widget.AirportList;
    // getAirportData();
    // getData();
  }

  @override
  Widget build(BuildContext context) {
    String? dropdownValue;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple[200],
          title: Text("Deals"),
          centerTitle: true,
        ),
        body: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.purple, width: 1),
                  borderRadius: BorderRadius.circular(15)),
              child: DropdownButton(
                value: dropdownValue,
                // hint: Text("Choose Airport: "),
                icon: const Icon(Icons.arrow_drop_down),
                iconSize: 24,
                elevation: 16,
                isExpanded: true,
                style: const TextStyle(color: Colors.deepPurple),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue;
                    print("Dropdown value: - ");
                    print(dropdownValue);
                  });
                },
                // items: <String>[
                //   'IGI Airport 1',
                //   'IGI Airport 2',
                //   'IGI Airport 3',
                //   'IGI Airport 4'
                // ].map<DropdownMenuItem<String>>((String value) {
                //   return DropdownMenuItem<String>(
                //     value: value,
                //     child: Text(value),
                //   );
                // }).toList(),
                items: AirportList.map((valueItem) {
                  return DropdownMenuItem<String>(
                      value: valueItem, child: Text(valueItem));
                }).toList(),
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
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
                  child: Container(
                    //Container to resize the
                    padding: EdgeInsets.all(10),
                    height: 300,
                    child: Card(
                      margin: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: <Widget>[
                          Padding(padding: EdgeInsets.all(10)),
                          Container(
                              //Container for Circular Image
                              width: 80.0,
                              height: 80.0,
                              decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                      fit: BoxFit.fill,
                                      image: new NetworkImage(
                                          "https://assets.turbologo.com/blog/en/2020/01/19084716/armani-logo-cover-958x575.png")))),
                          Padding(padding: EdgeInsets.fromLTRB(0, 20, 20, 0)),
                          Text(
                            "Emporio Armani",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ]));
  }

  // Future<void> getData() async {
  //   var queryParameters = {"airport": "$dropdownValue"};
  //   var uri = Uri.https("", "", queryParameters);
  //   Response response = await get(uri);
  //   Map map = jsonDecode(response.body);
  // }

  // Future<void> getAirportData() async {
  //   Response response = await get(Uri.parse(""));
  //   Map map = jsonDecode(response.body);
  //   AirportList = map["Airport"];
  // }
}

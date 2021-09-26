import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:smart_journey_experience/SupportClasses/Deal.dart';
import 'package:smart_journey_experience/SupportClasses/DealCard.dart';

class Deals extends StatefulWidget {
  var AirportList;
  Deals({Key? key, @required this.AirportList}) : super(key: key);

  @override
  _DealsState createState() => _DealsState();
}

class _DealsState extends State<Deals> {
  List AirportList = [];

  @override
  void initState() {
    super.initState();
    AirportList = widget.AirportList;
    print(AirportList);
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
            child: FutureBuilder(
                future: getData(dropdownValue),
                builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                  if (snapshot.hasData != true) {
                    return Container(
                        child: Center(
                      child: Text("Nothing Loaded"),
                    ));
                  } else {
                    return GridView.builder(
                        itemCount: snapshot.data.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        itemBuilder: (BuildContext ct, index) {
                          return DealCard(deal: snapshot.data[index]);
                        });
                  }
                }),
          ),
        ]));
  }

  Future<List<Deal>> getData(String? dropdown) async {
    List<Deal> DealList = [];
    Map<String, String> queryParams = {"airport": "$dropdown"};
    // var uri = Uri.parse('http://192.168.1.22:5000/');
    String queryString = Uri(queryParameters: queryParams).query;
    var requesturl = 'http://192.168.1.22:5000/?' + queryString;
    var uri = Uri.parse(requesturl);
    Response response = await get(uri);
    var ResList = jsonDecode(response.body);
    List<Deal> dealList = [];
    for (var i = 0; i < ResList.length; i++) {
      // print(ResList[i]["name"]);
      Deal d = new Deal(
          Shop_name: ResList[i]["name"],
          loc: ResList[i]["location"],
          heading: ResList[i]["Heading"],
          simple_text: ResList[i]["simple"],
          photo: ResList[i]["photo"]);
      DealList.add(d);
    }
    return DealList;
  }
}

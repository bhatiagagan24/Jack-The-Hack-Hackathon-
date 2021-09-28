import 'dart:convert';

import 'package:flutter/material.dart';
import './app_assistance.dart';
import 'package:smart_journey_experience/screens/app_flight_details.dart';
// import 'app_lounge.dart';
import 'app_loungea.dart';
import 'package:http/http.dart';

class AirportSelect extends StatefulWidget {
  List AirportList;
  String user_name, user_email, route;
  AirportSelect(
      {Key? key,
      required this.AirportList,
      required this.user_name,
      required this.user_email,
      required this.route})
      : super(key: key);

  @override
  _AirportSelectState createState() => _AirportSelectState();
}

class _AirportSelectState extends State<AirportSelect> {
  int selectedIndex = -1;
  String? choosen_option;
  List<String> lounge_list = [];
  @override
  void initState() {
    // TODO: implement initState
    print(widget.AirportList);
  }

  @override
  Widget build(BuildContext context) {
    List AirportList = widget.AirportList;
    String user_name = widget.user_name;
    String user_email = widget.user_email;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Airport",
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple.shade200,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(padding: EdgeInsets.all(10)),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "Welcome",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple),
            ),
          ),
          Padding(padding: EdgeInsets.all(10)),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "Where are you flying from?",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  color: Colors.purple[100]),
            ),
          ),
          Padding(padding: EdgeInsets.all(10)),
          Expanded(
              child: GridView.builder(
                  itemCount: AirportList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (BuildContext ct, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                          choosen_option = AirportList[index];
                        });
                      },
                      child: Container(
                        //Container to resize the
                        padding: EdgeInsets.all(20),
                        child: Card(
                          shape: (selectedIndex == index)
                              ? RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(color: Colors.green))
                              : RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                          child: Center(child: Text(AirportList[index])),
                        ),
                      ),
                    );
                  })),
          MaterialButton(
            onPressed: () {},
            child: Text('I want to Explore'),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            if (choosen_option!.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Please choose Airport')));
            } else {
              if (widget.route == "Accessibility") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Assistance(
                            user_name: widget.user_name,
                            user_email: widget.user_email,
                            airport: "$choosen_option",
                          )),
                );
              } else if (widget.route == "Lounges") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Lounge(
                            user_name: widget.user_name,
                            user_email: widget.user_email,
                            lounge_list: this.lounge_list,
                          )), //To CHange
                );
              } else if (widget.route == "Help") {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => Assistance(
                //           user_name: widget.user_name,
                //           user_email: widget.user_email,
                //           airport: "$choosen_option")), //To CHange
                // );
              }
            }
          },
          child: Text('Next'),
        ),
      ),
    );
  }

  Future<void> get_Lounge_data(var airport) async {
    Map<String, String> queryParams = {
      "airport": "$airport",
      // "email": "$user_email"
    };
    String queryString = Uri(queryParameters: queryParams).query;
    var requesturl = 'http://192.168.1.10:5000/user/add/info?' + queryString;
    var uri = Uri.parse(requesturl);
    Response response = await get(uri);
    lounge_list = (jsonDecode(response.body) as List<dynamic>).cast<String>();
  }
}

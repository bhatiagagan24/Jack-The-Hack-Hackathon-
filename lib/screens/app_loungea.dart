import 'dart:convert';
import 'dart:developer';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import './app_assistance.dart';
import './app_lounge_dashboard.dart';
import 'package:smart_journey_experience/screens/app_flight_details.dart';

class Lounge extends StatefulWidget {
  String user_name, user_email;
  // List lounge_list;
  var airport_name;
  Lounge(
      {Key? key,
      required this.user_name,
      required this.user_email,
      // required this.lounge_list,
      required this.airport_name})
      : super(key: key);

  @override
  _LoungeState createState() => _LoungeState();
}

class _LoungeState extends State<Lounge> {
  int selectedIndex = -1;
  var display_things = 0;
  String? choosen_option;

  @override
  Widget build(BuildContext context) {
    // List lounge_list = [];
    var chosen_option;
    String airport_name = widget.airport_name;
    var screen_width = MediaQuery.of(context).size.width;
    // void initState() {
    //   print("Inside initstate");
    //   log("inside initstate");
    //   // print('lounge list- --- > ${lounge_list}');
    // }

    Future<List> get_Lounge_data(var airport) async {
      Map<String, String> queryParams = {
        "airport": "$airport",
        // "email": "$user_email"
      };
      String queryString = Uri(queryParameters: queryParams).query;
      var requesturl = 'http://192.168.1.10:5000/lounge/fetch?' + queryString;
      var uri = Uri.parse(requesturl);
      Response response = await get(uri);
      print("Response body -> {response.body}");
      // setState(() {
      List lounge_list =
          (jsonDecode(response.body) as List<dynamic>).cast<String>();

      return lounge_list;
    }

    return Stack(children: [
      Image.network(
          "https://images.unsplash.com/photo-1504150558240-0b4fd8946624?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=764&q=80"),
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
            FutureBuilder(
              future: get_Lounge_data(airport_name),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData == true) {
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            // InkWell()

                            InkWell(
                              onTap: () {
                                setState(() {
                                  choosen_option = snapshot.data[index];
                                  print(
                                      "choosen_option ----> ${choosen_option}");
                                });
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoungeDashboard(
                                              user_name: widget.user_name,
                                              user_email: widget.user_email,
                                              name: "$choosen_option",
                                            )));
                              },
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Card(
                                      child: Container(
                                        color: Colors.black,
                                        width: screen_width / 1.3,
                                        height: 60,
                                        alignment: Alignment.center,
                                        child: Text(
                                          snapshot.data[index],
                                          style: TextStyle(
                                              color:
                                                  Colors.amberAccent.shade100,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 25),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 70, 0, 30))
                                  ]),
                            ),
                          ],
                          // ),
                        );
                      });
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
            // Padding(padding: EdgeInsets.all(10)),
            // Padding(
            //   padding: const EdgeInsets.only(left: 20),
            //   child: Text(
            //     "Welcome",
            //     style: TextStyle(
            //         fontSize: 25,
            //         fontWeight: FontWeight.bold,
            //         color: Colors.yellow.shade400),
            //   ),
            // ),
            // Padding(padding: EdgeInsets.all(10)),
            //     Expanded(
            //         child: GridView.builder(
            //             itemCount: lounge_list.length,
            //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //                 crossAxisCount: 2),
            //             itemBuilder: (BuildContext ct, index) {
            //               return InkWell(
            //                 onTap: () {
            //                   setState(() {
            //                     selectedIndex = index;
            //                     choosen_option = lounge_list[index];
            //                   });
            //                 },
            //                 child: Container(
            //                   //Container to resize the
            //                   padding: EdgeInsets.all(20),
            //                   child: Card(
            //                     shape: (selectedIndex == index)
            //                         ? RoundedRectangleBorder(
            //                             borderRadius: BorderRadius.circular(10.0),
            //                             side: BorderSide(
            //                                 color: Colors.yellow.shade400))
            //                         : RoundedRectangleBorder(
            //                             borderRadius: BorderRadius.circular(10.0),
            //                           ),
            //                     child: Center(
            //                         child: Text(lounge_list[index],
            //                             style: TextStyle(
            //                                 fontSize: 13,
            //                                 fontWeight: FontWeight.bold,
            //                                 color: Colors.black))),
            //                   ),
            //                 ),
            //               );
            //             }))
            //   ],
            // ),
            // bottomNavigationBar: Padding(
            //   padding: EdgeInsets.all(8.0),
            //   child: ElevatedButton(
            //     onPressed: () {
            //       if (choosen_option!.isEmpty) {
            //         ScaffoldMessenger.of(context).showSnackBar(
            //             SnackBar(content: Text('Please choose Lounge')));
            //       } else {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) => LoungeDashboard(
            //                     user_name: widget.user_name,
            //                     user_email: widget.user_email,
            //                     name: "$choosen_option",
            //                   )),
            //         );
            //       }
            //     },
            //     child: Text('Next'),
            //   ),
            // ),
            // ),
          ],
        ),
      ),
    ]);
  }
}

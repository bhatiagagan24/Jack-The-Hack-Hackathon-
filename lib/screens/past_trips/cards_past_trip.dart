// // ignore_for_file: non_constant_identifier_names

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class CardsPastTrips extends StatefulWidget {
//   var user_name;
//   var user_email;
//   CardsPastTrips(
//       {Key? key, @required this.user_email, @required this.user_name})
//       : super(key: key);

//   @override
//   State<CardsPastTrips> createState() => _CardsPastTripsState();
// }

// class _CardsPastTripsState extends State<CardsPastTrips> {
//   @override

//   // function to fetch all the trips of the user
// //   Future<List<Deal>> getData(String? dropdown) async {
// //     List<Deal> DealList = [];
// //     Map<String, String> queryParams = {"airport": "$dropdown"};
// //     // var uri = Uri.parse('http://192.168.1.22:5000/');
// //     String queryString = Uri(queryParameters: queryParams).query;
// //     var requesturl = 'http://192.168.1.22:5000/?' + queryString;
// //     var uri = Uri.parse(requesturl);
// //     Response response = await get(uri);
// //     var ResList = jsonDecode(response.body);
// //     List<Deal> dealList = [];
// //     for (var i = 0; i < ResList.length; i++) {
// //       // print(ResList[i]["name"]);
// //       Deal d = new Deal(
// //           Shop_name: ResList[i]["name"],
// //           loc: ResList[i]["location"],
// //           heading: ResList[i]["Heading"],
// //           simple_text: ResList[i]["simple"],
// //           photo: ResList[i]["photo"]);
// //       DealList.add(d);//     }
// //     return DealList;
// //   }
// // }

//   Future<void> fetchPast_Trips() async {
//     var urlString = 'http://192.168.1.10:5000/user/info/fetch?';
//     var queryParam = {"username": widget.user_name, "email": widget.user_email};
//     var queryString = Uri(queryParameters: queryParam).query;
//     var url = Uri.parse(urlString + queryString);
//     http.Response resp = await http.get(url);
//     print(resp.body);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [],
//         title: Text('My Trips'),
//       ),
//       body: new FutureBuilder(
//         future: fetchPast_Trips()
//         builder: builder),
//         ],
//       ),
//     );
//   }
// }

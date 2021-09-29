import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smart_journey_experience/SupportClasses/PaymentCard.dart';
import 'package:smart_journey_experience/screens/app_payment_add.dart';
import 'package:http/http.dart';

class Payment extends StatefulWidget {
  var username;
  var email;
  Payment({Key? key, required this.username, required this.email})
      : super(key: key);

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  List card_number_list = [];
  Future<void> fetch_payment_data() async {
    Map<String, String> queryParams = {
      // "loungename": "$loungename",
      "email": "${widget.email}", "username": "${widget.username}"
    };
    String queryString = Uri(queryParameters: queryParams).query;
    var requesturl = 'http://192.168.1.10:5000/food/fetch?' + queryString;
    var uri = Uri.parse(requesturl);
    Response response = await get(uri);
    card_number_list =
        (jsonDecode(response.body) as List<dynamic>).cast<String>();
  }

  @override
  void initState() {
    fetch_payment_data();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.black,
            centerTitle: true,
            title: Text(
              "Payment Methods",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[400]),
            )),
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                  itemCount: card_number_list.length,
                  itemBuilder: (BuildContext cx, index) =>
                      PaymentCard(CardNo: card_number_list[index])),
            )
          ],
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.fromLTRB(100, 0, 100, 20),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.green.shade400,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), // <-- Radius
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PaymentAdd(
                          username: this.widget.username,
                          email: this.widget.email,
                        )),
              );
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FaIcon(
                  FontAwesomeIcons.plusCircle,
                  color: Colors.black,
                ),
                Text("Add Payment"),
              ],
            ),
          ),
        ));
  }
}

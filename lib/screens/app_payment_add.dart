import 'package:http/http.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'app_payment.dart';

class PaymentAdd extends StatefulWidget {
  var username;
  var email;
  PaymentAdd({Key? key, required this.username, required this.email})
      : super(key: key);

  @override
  _PaymentAddState createState() => _PaymentAddState();
}

class _PaymentAddState extends State<PaymentAdd> {
  TextEditingController _cardNo = TextEditingController();
  String res = "";
  Future<void> send_payment_data() async {
    Map<String, String> queryParams = {
      "email": "${widget.email}",
      "username": "${widget.username}",
      "service": "${_cardNo.text}"
    };
    String queryString = Uri(queryParameters: queryParams).query;
    var requesturl = 'http://192.168.1.10:5000/user/add/payment?' + queryString;
    var uri = Uri.parse(requesturl);
    Response response = await get(uri);
    res = response.body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.black,
            centerTitle: true,
            title: Text(
              "Add Payment",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[400]),
            )),
        body: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(30)),
            Container(
                child: Card(
              elevation: 7,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              color: Colors.green[300],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(left: 20, top: 20),
                          child: FaIcon(
                            FontAwesomeIcons.dollarSign,
                            size: 30,
                            color: Colors.white,
                          ))
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, top: 20),
                    child: Text(
                      "CARD NUMBER",
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: TextField(
                      controller: _cardNo,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: "0000 0000 0000 0000",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                  ),
                ],
              ),
            ))
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
              send_payment_data();
              if (res == "1") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Payment(
                            username: this.widget.username,
                            email: this.widget.email,
                          )),
                );
              } else if (res == "-1") {}
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

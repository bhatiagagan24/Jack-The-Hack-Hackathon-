import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'app_payment.dart';

class PaymentAdd extends StatefulWidget {
  const PaymentAdd({Key? key}) : super(key: key);

  @override
  _PaymentAddState createState() => _PaymentAddState();
}

class _PaymentAddState extends State<PaymentAdd> {
  TextEditingController _cardNo = TextEditingController();
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Payment()),
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

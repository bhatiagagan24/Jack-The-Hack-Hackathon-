import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smart_journey_experience/SupportClasses/PaymentCard.dart';
import 'package:smart_journey_experience/screens/app_payment_add.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    List payments = [
      "0000 00000 0000 0000",
      "0000 00000 0000 0000",
      "0000 00000 0000 0000"
    ];
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
                  itemCount: payments.length,
                  itemBuilder: (BuildContext cx, index) =>
                      PaymentCard(CardNo: payments[index])),
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
                MaterialPageRoute(builder: (context) => PaymentAdd()),
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

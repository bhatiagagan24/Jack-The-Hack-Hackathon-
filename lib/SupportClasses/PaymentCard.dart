import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PaymentCard extends StatelessWidget {
  String CardNo;
  PaymentCard({Key? key, required this.CardNo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Text(
                  "CARD NUMBER",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Text(
                  CardNo,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}

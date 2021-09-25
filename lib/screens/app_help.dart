import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Help extends StatelessWidget {
  const Help({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightGreen,
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 60,
            ),
            Center(
              child: Text(
                "Help",
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
            ),
            Padding(padding: EdgeInsets.all(40)),
            Container(
              width: 450,
              height: 450,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 5,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 40),
                    FaIcon(FontAwesomeIcons.question,
                        size: 50.0, color: Colors.red),
                    SizedBox(height: 40),
                    Center(
                        child: Text(
                      "You can contact from details given below:",
                      style: TextStyle(fontSize: 20),
                    )),
                    Padding(padding: EdgeInsets.all(15)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          "0120 - 4574567",
                          style: TextStyle(fontSize: 20),
                        ),
                        FaIcon(FontAwesomeIcons.phone, color: Colors.red)
                      ],
                    ),
                    Padding(padding: EdgeInsets.all(10)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          "help@gmail.com",
                          style: TextStyle(fontSize: 20),
                        ),
                        FaIcon(FontAwesomeIcons.envelope, color: Colors.red)
                      ],
                    ),
                  ],
                ),
                margin: EdgeInsets.all(10.0),
              ),
            )
          ],
        ));
  }
}
